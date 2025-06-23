import { BaseModel } from "./model";

export interface UserDocument extends BaseModel {
  // personal info
  firstName?: string;
  lastName?: string;
  email: string;
  password: string;
  passwordConfirm: string;
  isVerified?: boolean;
  // tokens
  verificationToken?: string;
  passwordResetToken?: string;
  verifiedAt?: Date;
  verificationTokenExpiresAt?: Date;
  passwordResetExpires?: Date;
  deletionTokenExpiresAt?: Date;
  loggedOutAt?: Date;
  loggedInAt?: Date;
  passwordChangedAt?: Date;
  // methods
  correctPassword(candidatePassword: string, userPassword: string): Promise<boolean>;
  changedPassAfter(JWTTimestamp: number): boolean;
  generateResetToken(): string;
  generateVerificationToken(): string;
  generateLoginToken(): string;
  generateDeletionToken(): string;
}
