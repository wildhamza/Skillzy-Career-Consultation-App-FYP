class AppError extends Error {
  statusCode: number;

  status: "success" | "error" | "fail";

  isOperational: boolean;

  code: number;

  _message: string;

  errors: { message: string }[];

  path: string;

  value: string;

  constructor(message: string, statusCode: number) {
    super(message);

    this.statusCode = statusCode;
    this.status = `${statusCode}`.startsWith("4") ? "fail" : "error";
    this.isOperational = true;

    Error.captureStackTrace(this, this.constructor);
  }
}

export default AppError;
