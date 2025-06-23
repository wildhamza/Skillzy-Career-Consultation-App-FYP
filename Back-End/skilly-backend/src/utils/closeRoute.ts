import AppError from "./AppError";
import catchAsync from "./catchAsync";

export default catchAsync(async (req, res, next) => next(new AppError("Not currently available", 404)));
