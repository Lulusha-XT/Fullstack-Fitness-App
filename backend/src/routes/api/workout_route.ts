import express from "express";
import WorkoutController from "../../controllers/workout_controllers.js";

const workoutRouter: express.Router = express();
workoutRouter.get("/", WorkoutController.getAllWorkout);
workoutRouter.post("/", WorkoutController.createNewWorkout);
workoutRouter.get("/excercises", WorkoutController.getAllWorkoutExcersise);
workoutRouter.post("/excercises", WorkoutController.createNewWorkoutExcercise);

export default workoutRouter;
