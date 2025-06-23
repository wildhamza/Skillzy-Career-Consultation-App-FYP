import { NextFunction, Request, Response } from "express";

import AppError from "../utils/AppError";
import responseBody from "../utils/responseBody";

const handleCastErrorDB = (err: AppError) => {
  const message = `Invalid ${err.path.replace(/_/g, "")}: ${err.value}.`;
  return new AppError(message, 400);
};

const handleDuplicateFieldsDB = (err: AppError) => {
  const key = err.message.match(/\{ (.*?): /)[1];
  // const value = err.message.match(/(["'])(\\?.)*?\1/)[0];

  const message = `This ${key} has already been taken.`;
  return new AppError(message, 400);
};

const handleValidationErrorDB = (err: AppError) => {
  const errors = Object.values(err.errors).map((el) => el.message);

  const message = `Invalid input data. ${errors.join(". ")}`;
  return new AppError(message, 400);
};

const handleJWTError = () => new AppError("Invalid token. Please log in again!", 401);

const handleJWTExpiredError = () => new AppError("Your token has expired! Please log in again.", 401);

const sendErrorDev = (err: AppError, req: Request, res: Response) => {
  // A) API
  if (req.originalUrl.startsWith("/api")) {
    return responseBody({
      res,
      status: err.status,
      statusCode: err.statusCode,
      error: err,
      message: err.message,
      stack: err.stack
    });
  }

  // B) RENDERED WEBSITE
  console.error("ERROR 💥", err); // eslint-disable-line no-console
  return res.status(err.statusCode).render("error", {
    title: "Something went wrong!",
    msg: err.message
  });
};

const sendErrorProd = (err: AppError, req: Request, res: Response) => {
  // A) API
  if (req.originalUrl.startsWith("/api")) {
    // A) Operational, trusted error: send message to client
    if (err.isOperational) {
      return responseBody({
        res,
        status: err.status,
        statusCode: err.statusCode,
        message: err.message
      });
    }
    // B) Programming or other unknown error: don't leak error details
    // 1) Log error
    console.error("ERROR 💥", err); // eslint-disable-line no-console
    // 2) Send generic message
    return responseBody({
      res,
      status: "error",
      statusCode: 500,
      message: "Internal server error!"
    });
  }

  // B) RENDERED WEBSITE
  // A) Operational, trusted error: send message to client
  if (err.isOperational) {
    return res.status(err.statusCode).render("error", {
      title: "Something went wrong!",
      msg: err.message
    });
  }
  // B) Programming or other unknown error: don't leak error details
  // 1) Log error
  console.error("ERROR 💥", err); // eslint-disable-line no-console
  // 2) Send generic message
  return res.status(err.statusCode).render("error", {
    title: "Something went wrong!",
    msg: "Please try again later."
  });
};

// eslint-disable-next-line @typescript-eslint/no-unused-vars, prettier/prettier
const Error = (err: AppError, req: Request, res: Response, _next: NextFunction) => { // four arguments are required for error controller
  err.statusCode = err.statusCode || 500;
  err.status = err.status || "error";
  if (process.env.NODE_ENV === "developement") {
    sendErrorDev(err, req, res);
  } else if (process.env.NODE_ENV === "production") {
    let error = { ...err };
    error.message = err.message;
    error.name = err.name;

    if (error._message && error._message.toLowerCase().includes("validation failed")) error.isOperational = true;
    if (error.name === "CastError") error = handleCastErrorDB(error);
    if (error.code === 11000) error = handleDuplicateFieldsDB(error);
    if (error.name === "ValidationError") error = handleValidationErrorDB(error);
    if (error.name === "JsonWebTokenError") error = handleJWTError();
    if (error.name === "TokenExpiredError") error = handleJWTExpiredError();

    sendErrorProd(error, req, res);
  }
};

const error = Error;

export default error;
