import { Request as Req } from "express";

import { UserDocument } from "./user";

export default interface Request extends Req {
  requestTime: string;
  user: UserDocument;
  findOptions: Record<string, string>;
  locals: Record<string, unknown>;
}
