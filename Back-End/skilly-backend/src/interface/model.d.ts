import { Document, Schema } from "mongoose";

export interface BaseModel extends Document {
  autoId: number;
  id: Schema.Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}
