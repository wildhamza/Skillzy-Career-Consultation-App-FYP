import express from "express";

import * as authController from "../controllers/auth";
import * as recommendationController from "../controllers/recommendation";
// import fileUpload from "../utils/multer";

const router = express.Router();

router.use(authController.protect);

router.post("/recommend-career", recommendationController.recommendCareerPath);

const recommendationRouter = router;
export default recommendationRouter;
