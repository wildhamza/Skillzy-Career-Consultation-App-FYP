declare module "xss-clean" {
  import { RequestHandler } from "express";

  interface XSSCleanOptions {
    allowedTags?: string[];
    allowedAttributes?: Record<string, string[]>;
  }

  interface XSSCleanMiddleware {
    (options?: XSSCleanOptions): RequestHandler;
  }

  const xssClean: XSSCleanMiddleware;

  export default xssClean;
}
