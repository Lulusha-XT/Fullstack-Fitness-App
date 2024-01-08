import express from "express";
import UserController from "../../controllers/user_controller.js";
import { verifyToken } from "../../middleware/auth.js";
import uploadProfilePicture from "../../middleware/user.upload.js";
import UserBookControllers from "../../controllers/user_book_controllers.js";
import UserGymControllers from "../../controllers/user_gym_controllers.js";
import UserFoodControllers from "../../controllers/user_food_controllers.js";
import UserExerciseControllers from "../../controllers/user_exercise_controllerss.js";

const userRouter: express.Router = express();

userRouter.post("/registor", UserController.createNewUser);
userRouter.put(
  "/update",
  verifyToken,
  uploadProfilePicture.single("profilePicture"),
  UserController.updateUserById
);
userRouter.post("/login", UserController.userLogin);
userRouter.get(
  "/likeExcercise",
  UserExerciseControllers.getAllUserLikeExcercise
);
userRouter.post("/likeExcercise", UserExerciseControllers.userLikeExcercise);
userRouter.get("/likeBook", UserBookControllers.getAllUserLikeBook);
userRouter.post("/likeBook", verifyToken, UserBookControllers.userLikeBook);
userRouter.get("/likeFood", UserFoodControllers.getAllUserLikeFood);
userRouter.post("/likeFood", verifyToken, UserFoodControllers.userLikeFood);
userRouter.post("/join/:gymId", verifyToken, UserGymControllers.joinUserToGym);
userRouter.post(
  "/leave/:gymId",
  verifyToken,
  UserGymControllers.leaveUserToGym
);
userRouter.get("/:id", UserController.getUserById);
userRouter.get("/", UserController.getAllUser);

export default userRouter;
