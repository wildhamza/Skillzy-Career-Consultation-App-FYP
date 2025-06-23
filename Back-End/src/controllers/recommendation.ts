import { spawn } from "child_process";

import Recommendation from "../models/recommendation";
import AppError from "../utils/AppError";
import catchAsync from "../utils/catchAsync";
import getMappedSkills from "../utils/mappedSkills";
import responseBody from "../utils/responseBody";

async function runPythonScript(inputData) {
  return new Promise((resolve, reject) => {
    const process = spawn("python3", ["./src/script/model-1/test-model.py", JSON.stringify(inputData)]);

    let stdoutData = "";
    let stderrData = "";

    process.stdout.on("data", (data) => {
      const text = data.toString("utf8");
      stdoutData += text;
    });

    process.stderr.on("data", (data) => {
      const text = data.toString("utf8");
      stderrData += text;
    });

    process.on("close", (code) => {
      if (code === 0) {
        resolve(stdoutData.trim()); // Return complete stdout output
      } else {
        reject(new Error(`Process exited with code ${code}\n${stderrData}`));
      }
    });

    process.on("error", (err) => {
      reject(err); // Handle startup errors (e.g., file not found)
    });
  });
}

export const recommendCareerPath = catchAsync(async (req, res, next) => {
  const userId = req.user._id;

  const { answers } = req.body;

  if (answers.length < 27) {
    return next(new AppError("Please answer all the questions", 400));
  }

  const result = await runPythonScript(answers);
  const recommendedCareer = String(result).split("step")[1].trim();
  const recommendedSkills = getMappedSkills(recommendedCareer);

  if (!recommendedCareer) {
    next(new AppError("No career recommendation found", 404));
  }

  const recommendation = await Recommendation.create({
    userId,
    recommendedCareer,
    recommendedSkills
  });

  responseBody({ res, statusCode: 200, status: "success", data: { recommendation }, message: "Career recommendation saved" });
});

export const getAllCareerPaths = catchAsync(async () => null);
