import express from "express";

import * as authController from "../controllers/auth";

const router = express.Router();

router.post("/signup", authController.signup);
router.post("/login", authController.login);
router.post("/forgot-password", authController.forgotPassword);
router.post("/verify-reset-password-otp", authController.verifyResetPasswordOTP);
router.post("/reset-password", authController.resetPassword);
router.post("/send-verification-email", authController.sendVerificationEmail);
router.post("/verify-email", authController.verifyEmail);
router.post("/verify-login", authController.verifyLogin);

router.use(authController.protect);

router.get("/logged-in", authController.isLoggedIn);
router.patch("/update-password", authController.updatePassword);
router.post("/logout", authController.logout);

const authRouter = router;
export default authRouter;
