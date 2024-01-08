import { Request, Response } from "express";
import { GymPost, GymPostStore } from "../models/gym_post.js";
import { IRequest } from "../middleware/auth.js";

class GymPostControllers {
  static createNewGymPost = async (
    req: Request,
    res: Response
  ): Promise<void> => {
    const gymPostStore: GymPostStore = new GymPostStore();

    const { gym_id, post_description } = req.body;
    const post_image_path = req.file?.path?.replace(/\\/g, "/") || "";
    console.log(`Image : ${post_image_path}`);
    if (!gym_id || !post_description || !post_image_path) {
      res.status(400).json({
        error:
          "gym_id, post_description , and post_image_path are required for the gym.",
      });
      return;
    }
    console.log(`Gym Password ${gym_id}`);

    try {
      const gymPost: GymPost = {
        gym_id: gym_id,
        post_description: post_description,
        post_image_path: post_image_path,
      };
      const newGymPost: GymPost | null = await gymPostStore.createGymPost(
        gymPost
      );

      if (newGymPost) {
        res.status(201).json({ message: "Success", data: newGymPost });
      } else {
        res.status(500).json({ error: "Failed to create the gym post." });
      }
    } catch (error) {
      console.error("Error creating gym:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
  static getAllGymPost = async (req: Request, res: Response): Promise<void> => {
    const gymPostStore: GymPostStore = new GymPostStore();

    try {
      const gymPosts = await gymPostStore.getAllGymPost();
      res.status(200).json({ message: "Success", data: gymPosts });
    } catch (error) {
      console.error("Error getting all gyms:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
  static getGymPostByGymId = async (req: Request, res: Response) => {
    const gymPostStore: GymPostStore = new GymPostStore();

    try {
      console.log("Get Gym Post By Id Executed");
      // Retrieve the gym ID from the route parameter
      const gym_id = parseInt(req.params.gym_id);
      // Check if gymId is a valid integer; if not, handle the error appropriately
      if (isNaN(gym_id)) {
        return res.status(400).json({ error: "Invalid Gym ID" });
      }
      // Fetch gym users based on gymId
      const gymPost = await gymPostStore.getAllGymPostByGymId(gym_id);
      res.status(200).json({ message: "Success", data: gymPost });
    } catch (error) {
      console.error("Error getting gym post:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
  static userLikeGymPost = async (req: IRequest, res: Response) => {
    try {
      console.log("userLikeGymPost By User Id Excuted");
      const userStore: GymPostStore = new GymPostStore();
      const userLikeGymPost = await userStore.userLikeGymPost(
        req.user?.user_id!,
        req.body.gym_post_id
      );
      res.json({ message: "Success", data: userLikeGymPost });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getLikeGymPostsByUserId = async (req: IRequest, res: Response) => {
    const gymStore: GymPostStore = new GymPostStore();

    try {
      console.log("Get Gym Post By User Id Executed");
      // Retrieve the gym ID from the route parameter
      const user_id = req.user?.user_id;
      // Check if gymId is a valid integer; if not, handle the error appropriately
      if (isNaN(user_id!)) {
        return res.status(400).json({ error: "Invalid user ID" });
      }
      // Fetch gym users based on gymId
      const gymPost = await gymStore.getLikeGymPostsByUserId(user_id!);
      res.status(200).json({ message: "Success", data: gymPost });
    } catch (error) {
      console.error("Error getting gym post:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
}

export default GymPostControllers;
