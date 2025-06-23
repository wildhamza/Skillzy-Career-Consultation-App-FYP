import { capitalize, pick } from "lodash";

import User from "../models/user";
import AppError from "../utils/AppError";
import catchAsync from "../utils/catchAsync";
import responseBody from "../utils/responseBody";

// Update my data
const updateMe = catchAsync(async (req, res, next) => {
  // create error if user inputs password data
  if (req.body.password || req.body.passwordConfirm) {
    return next(new AppError("You can't update the password here ", 400));
  }

  // filtered unwanted fields that are not allowed to update
  const filteredFields = ["First Name", "Last Name"];
  const filteredBody = pick(
    req.body,
    ...filteredFields.map((field) => {
      const lowercase = field.split(" ")[0];
      field = field.replace(lowercase, "").trim();
      const result = lowercase.toLowerCase() + field.split(" ").join("");

      return result;
    })
  );

  const filteredUserData = pick(
    req.user,
    ...filteredFields.map((field) => {
      const arr = field.split(" ");

      return arr[0].toLowerCase() + (arr[1] ? capitalize(arr[1]) : "");
    })
  );

  const userData = filteredUserData;

  Object.assign(userData, filteredBody);

  // update user document
  const user = await User.findByIdAndUpdate(req.user._id, userData, {
    new: true,
    runValidators: true
  });

  responseBody({ res, statusCode: 200, status: "success", message: "Your profile is updated", data: { user } });
});

export default {
  updateMe
};
