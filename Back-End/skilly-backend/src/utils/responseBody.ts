import { Response } from "express";

import AppError from "./AppError";

interface ResponseBody {
  res: Response;
  results?: number;
  statusCode: number;
  status: "success" | "error" | "fail";
  message?: string;
  data?: unknown;
  token?: string;
  stack?: string;
  error?: AppError;
}

const responseBody = ({ res, statusCode, status, results, message, data, token }: ResponseBody): void => {
  res.status(statusCode).json({
    status,
    results,
    token,
    message,
    data
  });
};

export default responseBody;
