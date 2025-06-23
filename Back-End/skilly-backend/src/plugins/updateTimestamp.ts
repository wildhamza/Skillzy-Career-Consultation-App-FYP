import { Schema } from "mongoose";

/**
 * Updates updatedAt field when a model in updated
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const updateTimestampsPlugin = (schema: Schema<any>) => {
  // Add the `createdAt` field to the schema
  schema.add({
    createdAt: {
      type: Date,
      default: Date.now
    }
  });

  // Add the `updatedAt` field to the schema
  schema.add({
    updatedAt: {
      type: Date,
      default: Date.now
    }
  });

  // Define the pre-hook to update the `updatedAt` field before saving
  schema.pre(["save", "findOneAndUpdate"], function (next) {
    this.set({ updatedAt: new Date() });

    next();
  });
};

export default updateTimestampsPlugin;
