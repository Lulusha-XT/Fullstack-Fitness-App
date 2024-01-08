import express from "express";
import ExerciseController from "../../controllers/exercise_controller.js";
import uploads from "../../middleware/exercise.upload.js";

const exerciseRouter: express.Router = express();

exerciseRouter.get("/", ExerciseController.getAllExercise);
exerciseRouter.post(
  "/",
  uploads.array("exercise_files"),
  ExerciseController.createNewExercise
);
exerciseRouter.get("/categories", ExerciseController.getAllExerciseCategories);
exerciseRouter.post(
  "/categories",
  ExerciseController.createNewExerciseCategory
);

export default exerciseRouter;
