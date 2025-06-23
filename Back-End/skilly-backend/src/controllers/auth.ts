import crypto from "crypto";
import { promisify } from "util";

import { NextFunction, Response } from "express";
import jwt from "jsonwebtoken";
import { Types, Schema } from "mongoose";

import Request from "../interface/controller_request";
import { UserDocument } from "../interface/user";
import User from "../models/user";
import AppError from "../utils/AppError";
import catchAsync from "../utils/catchAsync";
import Email from "../utils/email";
import responseBody from "../utils/responseBody";

type signArgs = {
  id: Schema.Types.ObjectId;
  gym?: Types.ObjectId;
};

// creates a token by taking user id as an argument
const signToken = (args: signArgs) => {
  return jwt.sign(args, process.env.JWT, {
    expiresIn: process.env.JWT_EXPIRE
  });
};

const createTokenAndCookies = (res: Response, user: UserDocument) => {
  const token = signToken({ id: user._id });

  // create cookie
  const cookieOptions = {
    expires: new Date(Date.now() + +process.env.JWT_COOKIE_EXPIRES_IN /* days */ * 24 /* hr */ * 60 /* min */ * 60 /* sec */ * 1000 /* ms */),
    secure: process.env.NODE_ENV === "production",
    httpOnly: true,
    sameSite: false
  };
  res.cookie("jwt", token, cookieOptions);

  return token;
};

// creates a token to login the user
export const createSendToken = async (user: UserDocument, statusCode: number, res: Response, message?: string) => {
  const token = user.isVerified ? createTokenAndCookies(res, user) : undefined;

  const localUser = user.$clone();

  // remove encrypted user password from response
  localUser.loggedInAt = undefined;
  localUser.loggedOutAt = undefined;
  localUser.verifiedAt = undefined;
  localUser.password = undefined;
  localUser.passwordChangedAt = undefined;
  localUser.verificationToken = undefined;
  localUser.verificationTokenExpiresAt = undefined;

  responseBody({
    res,
    statusCode,
    status: "success",
    token,
    message,
    data: {
      user: localUser
    }
  });
};

// sends verificatin email
export const createVerificationEmail = async (user: UserDocument, _req: Request, next: NextFunction) => {
  const validationOTP = user.generateVerificationToken();

  await user.save({ validateBeforeSave: false, validateModifiedOnly: true });

  // eslint-disable-next-line no-console
  if (process.env.NODE_ENV === "developement") console.log({ token: validationOTP });

  try {
    // send email
    await new Email(user).sendVerificationEmail(validationOTP);

    return "Please verify your email! Check inbox/spam.";
  } catch (err) {
    // delete reset password token and expiration date and send error
    user.verificationToken = undefined;
    user.verificationTokenExpiresAt = undefined;
    await user.save({ validateBeforeSave: false });

    return next(new AppError("There was an error sending the email. Try again later", 500));
  }
};

// sends login verificatin email
export const createLoginEmail = async (user: UserDocument, _req: Request, next: NextFunction) => {
  const loginOTP = user.generateLoginToken();

  await user.save({ validateBeforeSave: false, validateModifiedOnly: true });

  // send token back as an email

  // eslint-disable-next-line no-console
  if (process.env.NODE_ENV === "developement") console.log({ token: loginOTP });

  try {
    // send email
    await new Email(user).sendLoginTokenEmail(loginOTP);

    return "Please check your email for OTP";
  } catch (err) {
    // delete reset password token and expiration date and send error
    // user.loginToken = undefined;
    // user.loginTokenExpiresAt = undefined;
    await user.save({ validateBeforeSave: false });

    return next(new AppError("There was an error sending the email. Try again later", 500));
  }
};

// SIGNUP
export const signup = catchAsync(async (req, res, next) => {
  // add data to database
  const existingUser = await User.findOne({ email: req.body.email });
  if (existingUser) {
    return next(new AppError("User with this email already exists", 400));
  }

  const user = await User.create({
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    email: req.body.email,
    password: req.body.password,
    passwordConfirm: req.body.passwordConfirm
  });

  try {
    const message = await createVerificationEmail(user, req, next);

    if (typeof message === "string") createSendToken(user, 201, res, message);
  } catch (err) {
    /* empty */
  }
});

// LOGIN
export const login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  // check if email and password exists
  if (!email || !password) {
    return next(new AppError("Please provide email and password", 400));
  }

  // check if email and password is correct
  const user = await User.findOne({ email }).select("+password");
  if (!user || !(await user.correctPassword(password, user.password))) {
    return next(new AppError("Incorrect email or password", 401));
  }

  // check if user is verified
  if (!user.isVerified) {
    const message = await createVerificationEmail(user, req, next);
    if (typeof message === "string") return responseBody({ res, statusCode: 200, status: "success", message });
    return message;
  }

  user.loggedInAt = new Date(Date.now());
  user.save({ validateBeforeSave: false });

  // if everything is okay, send token and user data to the client
  createSendToken(user, 200, res);
});

// LOGIN VERIFICATION
export const verifyLogin = catchAsync(async (req, res, next) => {
  const { email, otp } = req.body;
  if (!otp) return next(new AppError("Please provide an OTP", 400));

  const user = await User.findOne({ email }).select("+secret");

  if (!user) return next(new AppError("The user does not exist", 404));

  user.loggedInAt = new Date(Date.now());
  await user.save({ validateBeforeSave: false });

  createSendToken(user, 200, res, "You are successfully logged in");
});

// PROTECT PRIVATE ROUTES
export const protect = catchAsync(async (req, _res, next) => {
  let token = req.cookies.jwt;
  const secret: jwt.Secret = process.env.JWT;

  // get the token
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
    if (req.headers.authorization.split(" ")[1].startsWith("ey")) {
      token = req.headers.authorization.split(" ")[1];
    }
  }

  if (!token) {
    return next(new AppError("You are not logged in. Please login to get access", 401));
  }

  const promise = promisify<string, jwt.Secret>(jwt.verify);
  const decoded = (await promise(token, secret)) as unknown as Record<string, number>;

  // check if user exists
  const user = await User.findById(decoded.id).select("+fatSecretAccessToken +fatSecretAccessTokenExpiresAt +password");
  if (!user) {
    return next(new AppError("The user does not exist", 401));
  }

  // check if user is verified
  if (!user.isVerified) {
    return next(new AppError("You are not verified", 401));
  }

  // check if user changed password after token was issued
  if (user.changedPassAfter(decoded.iat)) {
    return next(new AppError("Your password has been changed. Please login again", 401));
  }

  req.user = ({ ...user } as any)._doc;

  next();
});

// ROLE BASED RESTRICTION
// export const restrictTo = (...roles: Role[]) => {
//   return catchAsync(async (req, _res, next) => {
//     if (!roles.includes(req.user.role)) {
//       return next(new AppError("You do not have permission to perform this action", 403));
//     }

//     return next();
//   });
// };

// FORGOT PASSWORD
export const forgotPassword = catchAsync(async (req, res, next) => {
  // get user based on inputted email
  const { email } = req.body;
  if (!email) {
    return next(new AppError("Please provide email", 400));
  }

  const user = await User.findOne({ email });
  if (!user) {
    return next(new AppError("The user does not exist", 404));
  }

  // generate random reset token
  const resetOTP = user.generateResetToken();
  await user.save({ validateBeforeSave: false });

  // eslint-disable-next-line no-console
  if (process.env.NODE_ENV === "developement") console.log(resetOTP);

  try {
    // send email
    await new Email(user).sendResetPasswordEmail(resetOTP);

    // send response to client
    responseBody({ res, statusCode: 200, status: "success", message: "Email sent. Check inbox/spam." });
  } catch (err) {
    // delete reset password token and expiration date and send error
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;
    await user.save({ validateBeforeSave: false });

    return next(new AppError("There was an error sending the email. Try again later", 500));
  }
});

// RESET PASSWORD OTP
export const verifyResetPasswordOTP = catchAsync(async (req, res, next) => {
  // get user based on token
  const { otp } = req.body;
  if (!otp) {
    return next(new AppError("Please provide reset token", 400));
  }

  const hashedToken = crypto.createHash("sha256").update(otp).digest("hex");

  const user = await User.findOne({ passwordResetToken: hashedToken, passwordResetExpires: { $gt: new Date(Date.now()) } })
    .select("+passwordResetToken")
    .select("+passwordResetExpires");

  // if token isn't expired and user exists, set the new password
  if (!user) {
    return next(new AppError("Token is invalid or expired", 404));
  }

  // check if user is verified
  // if (!user.isVerified) {
  //   responseBody({ res, statusCode: 200, status: "success", message: String(await createVerificationEmail(user, req, next)) });
  // }

  user.isVerified = true;
  await user.save();

  responseBody({ res, statusCode: 200, status: "success", data: { authenticated: true } });
});

// RESET PASSWORD
export const resetPassword = catchAsync(async (req, res, next) => {
  // get user based on token
  const { otp, password, password_confirm: passwordConfirm } = req.body;
  if (!otp) {
    return next(new AppError("Please provide reset token", 400));
  }

  const hashedToken = crypto.createHash("sha256").update(otp).digest("hex");

  const user = await User.findOne({ passwordResetToken: hashedToken, passwordResetExpires: { $gt: new Date(Date.now()) } })
    .select("+passwordResetToken")
    .select("+passwordResetExpires");

  // if token isn't expired and user exists, set the new password
  if (!user) {
    return next(new AppError("Token is invalid or expired", 404));
  }

  // check if user is verified
  // if (!user.isVerified) {
  //   responseBody({ res, statusCode: 200, status: "success", message: String(await createVerificationEmail(user, req, next)) });
  //   // return next(new AppError(`You are not verified`, 401));
  // }

  user.password = password;
  user.passwordConfirm = passwordConfirm;
  user.passwordResetToken = undefined;
  user.passwordResetExpires = undefined;
  await user.save();

  responseBody({ res, statusCode: 200, status: "success", message: "Password successfully recovered", data: user });
});

// SEND VERIFICATION EMAIL
export const sendVerificationEmail = catchAsync(async (req, res, next) => {
  const { email } = req.body;
  if (!email) {
    return next(new AppError("Please provide email", 400));
  }

  const user = await User.findOne({ email });
  if (!user) {
    return next(new AppError("The user does not exist", 404));
  }

  if (user.isVerified) {
    return next(new AppError("You are already verified", 400));
  }

  responseBody({ res, statusCode: 200, status: "success", message: String(await createVerificationEmail(user, req, next)) });
});

// VERIFY EMAIL
export const verifyEmail = catchAsync(async (req, res, next) => {
  const { otp } = req.body;
  if (!otp) {
    return next(new AppError("Please provide OTP code", 400));
  }

  // encrypting token to match the one in db
  const hashedToken = crypto.createHash("sha256").update(otp).digest("hex");

  // checking if user exists
  const user = await User.findOne({ verificationToken: hashedToken, verificationTokenExpiresAt: { $gt: new Date(Date.now()) } });

  // if token isn't expired and user exists, set the new password
  if (!user) {
    return next(new AppError("Token is invalid or expired", 404));
  }

  // saving user with updated data
  user.isVerified = true;
  user.verificationToken = undefined;
  user.verificationTokenExpiresAt = undefined;
  user.verifiedAt = new Date(Date.now());
  await user.save({ validateBeforeSave: false });

  // log the user in
  createSendToken(user, 200, res, "Your email is successfully verified");
});

// USER LOGIN STATUS
export const isLoggedIn = catchAsync(async (req, res) => {
  responseBody({
    res,
    statusCode: 200,
    status: "success",
    message: "Logged in",
    data: {
      user: req.user
    }
  });
});

// UPDATE PASSWORD
export const updatePassword = catchAsync(async (req, res, next) => {
  // get user from collection
  const user = await User.findById(req.user._id).select("+password");

  // check if inputted post is correct
  if (!(await user.correctPassword(req.body.current_password || "", user.password))) {
    return next(new AppError("Your current password is incorrect", 401));
  }

  // update password
  user.password = req.body.password;
  user.passwordConfirm = req.body.password_confirm;
  await user.save();

  // if everything is okay, send token and user data to the client
  createSendToken(user, 200, res);
});

// LOGOUT
export const logout = catchAsync(async (req, res) => {
  res.cookie("jwt", "loggedout", {
    expires: new Date(Date.now() + 10 * 1000),
    httpOnly: true
  });

  await User.findByIdAndUpdate(req.user._id, { loggedOutAt: new Date(Date.now()) }, { runValidators: false });

  responseBody({ res, statusCode: 200, status: "success", message: "Logged out successfully" });
});
