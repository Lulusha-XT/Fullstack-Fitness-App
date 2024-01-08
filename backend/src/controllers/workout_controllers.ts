import { Request, Response } from "express";
import { Workout, WorkoutStore } from "../models/workout.js";

class WorkoutController {
  static createNewWorkoutExcercise = async (req: Request, res: Response) => {
    try {
      const workoutStore: WorkoutStore = new WorkoutStore();
      const newWorkoutExcercise = await workoutStore.createWorkoutExcercise(
        req.body.workout_id,
        req.body.exercise_id
      );
      res.json(newWorkoutExcercise);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllWorkoutExcersise = async (req: Request, res: Response) => {
    try {
      const workoutStore = new WorkoutStore();
      const allWorkoutExcercises = await workoutStore.getAllWorkoutExcercises();
      res.json(allWorkoutExcercises);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static createNewWorkout = async (req: Request, res: Response) => {
    try {
      const workoutStore: WorkoutStore = new WorkoutStore();
      const workout: Workout = {
        workout_name: req.body.workout_name,
        workout_description: req.body.workout_description,
      };
      const newWorkout = await workoutStore.createWorkout(workout);
      res.json(newWorkout);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllWorkout = async (req: Request, res: Response) => {
    try {
      const workoutStore = new WorkoutStore();
      const allWorkout = await workoutStore.getAllWorkout();
      res.json(allWorkout);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default WorkoutController;
