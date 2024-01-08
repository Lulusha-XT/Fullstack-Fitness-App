import express from "express";
import GymPostControllers from "../../controllers/gym_post_controllers.js";
import uploadGymPost from "../../middleware/upload_gym_post.js";
import { verifyToken } from "../../middleware/auth.js";

const gymPostRouter: express.Router = express();

gymPostRouter.get(
  "/likeGymPost",
  verifyToken,
  GymPostControllers.getLikeGymPostsByUserId
);
gymPostRouter.post(
  "/likeGymPost",
  verifyToken,
  GymPostControllers.userLikeGymPost
);
gymPostRouter.get("/post/:gym_id", GymPostControllers.getGymPostByGymId);
gymPostRouter.get("/", GymPostControllers.getAllGymPost);
gymPostRouter.post(
  "/",
  uploadGymPost.single("image"),
  GymPostControllers.createNewGymPost
);

export default gymPostRouter;
