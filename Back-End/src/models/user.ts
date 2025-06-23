import crypto from "crypto";

import bcrypt from "bcryptjs";
import { Model, Query, Schema, model } from "mongoose";
import validator from "validator";

import { UserDocument } from "../interface/user";
import updateTimestampsPlugin from "../plugins/updateTimestamp";

const userSchema = new Schema<UserDocument>(
  {
    firstName: {
      type: String,
      trim: true
    },
    lastName: {
      type: String,
      trim: true
    },
    email: {
      type: String,
      required: [true, "Please provide an email"],
      unique: true,
      validate: [validator.isEmail, "Please provide a valid email"]
    },
    isVerified: {
      type: Boolean,
      default: false
    },
    verifiedAt: {
      type: Date
    },
    verificationToken: {
      type: String,
      select: false
    },
    verificationTokenExpiresAt: {
      type: Date,
      select: false
    },
    password: {
      type: String,
      minlength: [8, "A password must have at least 8 characters"],
      select: false
    },
    passwordConfirm: {
      type: String,
      validate: {
        validator: function (value: string) {
          if (this.password) {
            return value === this.password;
          }
          return true;
        },
        message: "Passwords are not the same"
      },
      select: false
    },
    passwordResetToken: {
      type: String,
      select: false
    },
    passwordResetExpires: {
      type: Date,
      select: false
    },
    loggedOutAt: {
      type: Date,
      select: false
    },
    loggedInAt: {
      type: Date,
      select: false
    }
  },
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  }
);

userSchema.virtual("fullName").get(function () {
  const { firstName, lastName } = this;
  const formattedFirstName = firstName ?? "";
  const formattedLastName = lastName ? ` ${lastName}` : "";

  return formattedFirstName + formattedLastName;
});

// eslint-disable-next-line import/no-mutable-exports
let User: Model<UserDocument>;

// runs when a password is modified
userSchema.pre<UserDocument>("save", async function (next) {
  // only runs if password was modified
  if (!this.isModified("password")) return;

  // encrypts the password and deletes the passwordConfirm field
  this.password = await bcrypt.hash(this.password, 12);
  this.passwordConfirm = undefined;
  next();
});

// runs when a user updates password
userSchema.pre<UserDocument>("save", async function (next) {
  if (!this.isModified("password") || this.isNew) return;
  this.passwordChangedAt = new Date(Date.now() - 1000);
  next();
});

// remove deactivated users from list
userSchema.pre<Query<UserDocument, UserDocument>>(/^find/, function () {
  this.find({ isActive: { $ne: false } });
});

userSchema.methods = {
  correctPassword: async function (candidatePassword: string, userPassword: string) {
    return await bcrypt.compare(candidatePassword, userPassword);
  }, // checks if inputted password matched the original user password
  changedPassAfter: function (JWTTimestamp: number) {
    if (this.passwordChangedAt) {
      const changedTimestamp = this.passwordChangedAt.getTime() / 1000;
      return JWTTimestamp < changedTimestamp + 2;
    }

    return false;
  }, // checks if password is changed after requesting the page
  generateResetToken: function () {
    const resetOTP = `${~~(Math.random() * 10e5)}`.padStart(6, "0");
    this.passwordResetToken = crypto.createHash("sha256").update(resetOTP).digest("hex");
    this.passwordResetExpires = new Date(Date.now() + 10 /* min */ * 60 /* sec */ * 1000 /* ms */);

    return resetOTP;
  }, // generates a password reset token
  generateVerificationToken: function () {
    const verificationOTP = `${~~(Math.random() * 10e5)}`.padStart(6, "0");
    this.verificationToken = crypto.createHash("sha256").update(verificationOTP).digest("hex");
    this.verificationTokenExpiresAt = new Date(Date.now() + 10 /* min */ * 60 /* sec */ * 1000 /* ms */);

    return verificationOTP;
  }, // generates a verification token
  generateLoginToken: function () {
    const loginOTP = `${~~(Math.random() * 10e5)}`.padStart(6, "0");
    this.loginToken = crypto.createHash("sha256").update(loginOTP).digest("hex");
    this.loginTokenExpiresAt = new Date(Date.now() + 10 /* min */ * 60 /* sec */ * 1000 /* ms */);

    return loginOTP;
  } // generates a login token
};

userSchema.plugin(updateTimestampsPlugin);

// eslint-disable-next-line prefer-const
User = model("User", userSchema);

export default User;
