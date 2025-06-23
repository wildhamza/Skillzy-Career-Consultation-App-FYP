import { BaseModel } from "./model";

export interface RecommendationDocument extends BaseModel {
  // personal info
  userId: Schema.Types.ObjectId;
  recommendedCareer: string;
  recommendedSkills: string[];
}
