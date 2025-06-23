import { Schema, model } from "mongoose";

import { RecommendationDocument } from "../interface/recommendation";
import updateTimestampsPlugin from "../plugins/updateTimestamp";

const recommendationSchema = new Schema<RecommendationDocument>(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: [true, "A recommendation must have a user ID"]
    },
    recommendedCareer: {
      type: String,
      required: [true, "A recommendation must have a career"],
      trim: true
    },
    recommendedSkills: {
      type: [String],
      required: [true, "A recommendation must have skills"]
    }
  },
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  }
);

recommendationSchema.plugin(updateTimestampsPlugin);

// eslint-disable-next-line prefer-const
const Recommendation = model("Recommendation", recommendationSchema);

export default Recommendation;
