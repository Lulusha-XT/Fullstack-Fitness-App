import { Request, Response, NextFunction } from "express";
import UserExerciseService from "../services/user_exercise_service.js";

class UserExerciseControllers {
  static userLikeExcercise = async (req: Request, res: Response) => {
    try {
      const userExerciseService: UserExerciseService =
        new UserExerciseService();
      const userLikeExcercise = userExerciseService.userLikeExercise(
        req.body.user_id,
        req.body.exercise_id
      );
      res.json({ message: "Success", data: userLikeExcercise });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllUserLikeExcercise = async (req: Request, res: Response) => {
    try {
      const userExerciseService: UserExerciseService =
        new UserExerciseService();
      const alluserLikeExcercise =
        await userExerciseService.getAllUserLikeExercise();
      res.json({ message: "Success", data: alluserLikeExcercise });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default UserExerciseControllers;
