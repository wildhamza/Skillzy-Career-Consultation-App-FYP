import path from "path";

import compression from "compression";
import cookieParser from "cookie-parser";
import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import mongoSanitize from "express-mongo-sanitize";
// import rateLimit from "express-rate-limit";
import helmet from "helmet";
import hpp from "hpp";
import morgan from "morgan";
import xss from "xss-clean";

import globalErrorController from "../controllers/error";
import Request from "../interface/controller_request";
import authRouter from "../routes/auth";
import recommendationRouter from "../routes/recommendation";
import userRouter from "../routes/user";
import AppError from "../utils/AppError";

dotenv.config({ path: "./.env" });

const app = express();

// enable pug templates
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "../", "views"));

// Middlewares -------------------------------------------------------------------------------

// serve static files

app.use(express.static(path.join(__dirname, "../../", "public")));

// enable Proxy
app.enable("trust proxy");

const url = process.env.FRONTEND_URL;

// implementing cors
app.use(cors({ origin: url, credentials: true }));

app.options("*", cors());

// set security http headers
app.use(helmet({ crossOriginResourcePolicy: { policy: "cross-origin" } }));
app.use(
  helmet.contentSecurityPolicy({
    directives: {
      defaultSrc: ["'self'"],
      formAction: ["'self'", "https://44.199.34.139:8080"]
      // Add any other necessary directives
    }
  })
);

// logger for dev mode only
if (process.env.NODE_ENV !== "production") app.use(morgan("dev"));

// limit requests from same api
// const limiter = rateLimit({
//   max: 100,
//   windowMs: 5 * 60 * 1000,
//   message: "Too many requests from this IP. Please try again in 5 minutes!"
// });
// app.use("/api", limiter);

app.use(express.json({ limit: "50mb" }));
app.use(cookieParser());

// data sanitization against noSQL query injection
app.use(mongoSanitize());

// data sanitization against XSS
app.use(xss());

// prevent parameter pollution
app.use(hpp({ whitelist: [] }));

// serving static files
app.use(express.static(path.join(__dirname, "public")));

app.use(compression());

// test middleware
app.use((req: Request, _res, next) => {
  req.requestTime = new Date().toISOString();
  req.findOptions = {};
  next();
});

// Routes -------------------------------------------------------------------------------
const apiRoutes = (slug: string) => `/api/v1/${slug}`;

app.use(apiRoutes("auth"), authRouter);
app.use(apiRoutes("users"), userRouter);
app.use(apiRoutes("recommendation"), recommendationRouter);

app.all("*", (req, _res, next) => {
  next(new AppError(`Can't find '${req.originalUrl}' on this server`, 404));
});

// Global Error -------------------------------------------------------------------------------

app.use(globalErrorController);

export default app;
