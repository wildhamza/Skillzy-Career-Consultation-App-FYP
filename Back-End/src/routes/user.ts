import express from "express";

import * as authController from "../controllers/auth";
import * as userController from "../controllers/user";
// import fileUpload from "../utils/multer";

const router = express.Router();

router.use(authController.protect);

router.patch("/update-me", userController.default.updateMe);

const userRouter = router;
export default userRouter;
