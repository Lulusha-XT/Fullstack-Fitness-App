import express from "express";
import userRouter from "./api/user_route.js";
import bookRouter from "./api/book_route.js";
import exerciseRouter from "./api/exercise_route.js";
import workoutRouter from "./api/workout_route.js";
import foodRouter from "./api/food_route.js";
import gymRouter from "./api/gym_routes.js";
import gymPostRouter from "./api/gym_post_route.js";

const router: express.Router = express();

router.use("/users", userRouter);
router.use("/books", bookRouter);
router.use("/exercises", exerciseRouter);
router.use("/workouts", workoutRouter);
router.use("/foods", foodRouter);
router.use("/gym", gymRouter);
router.use("/gympost", gymPostRouter);

export default router;
