import { Request, Response } from "express";
import {
  Exercise,
  ExerciseCategory,
  ExerciseStore,
} from "../models/exercise.js";

class ExerciseController {
  static createNewExerciseCategory = async (req: Request, res: Response) => {
    try {
      const exerciseStore = new ExerciseStore();
      const exerciseCategory: ExerciseCategory = {
        category_name: req.body.category_name,
      };
      const newExerciseCategory = await exerciseStore.createExerciseCategory(
        exerciseCategory
      );
      res.json(newExerciseCategory);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllExerciseCategories = async (req: Request, res: Response) => {
    try {
      const exerciseStore = new ExerciseStore();
      const allExercise = await exerciseStore.getAllExerciseCategories();
      res.json(allExercise);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };

  static createNewExercise = async (
    req: Request,
    res: Response
  ): Promise<void> => {
    try {
      const exerciseStore = new ExerciseStore();

      // Handle the uploaded files from req.files instead of req.file
      const exerciseFiles: Express.Multer.File[] =
        req.files as Express.Multer.File[];

      // Assuming you want to use the first uploaded file as the thumbnail
      const exerciseThumbnail: string =
        exerciseFiles.length > 0
          ? exerciseFiles[0].path.replace(/\\/g, "/")
          : "";

      // Assuming you want to use the second uploaded file as the book file path
      const exerciseVideoPath: string =
        exerciseFiles.length > 1
          ? exerciseFiles[1].path.replace(/\\/g, "/")
          : "";

      const exercise: Exercise = {
        exercise_name: req.body.exercise_name,
        exercise_description: req.body.exercise_description,
        exercise_thumbnail: exerciseThumbnail,
        exercise_video_path: exerciseVideoPath,
        exercise_category_id: req.body.exercise_category_id,
      };

      const newExercise = await exerciseStore.createExercise(exercise);
      res.json(newExercise);
    } catch (err) {
      res.status(400).json({ message: "error", error: `${err}` });
    }
  };

  static getAllExercise = async (req: Request, res: Response) => {
    try {
      const exerciseStore = new ExerciseStore();
      const allExercise = await exerciseStore.getAllExercises();
      res.json(allExercise);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default ExerciseController;
