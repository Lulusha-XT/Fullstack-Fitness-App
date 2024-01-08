import { Request, Response } from "express";
import { GymStore, Gym } from "../models/gym.js";
import { User } from "../models/user.js";

class GymController {
  static createNewGym = async (req: Request, res: Response): Promise<void> => {
    const gymStore: GymStore = new GymStore();
    const {
      gym_name,
      gym_monthly_payment,
      gym_location,
      gym_image,
      gym_password,
    } = req.body;

    if (!gym_name || !gym_monthly_payment || !gym_location || !gym_password) {
      res.status(400).json({
        error:
          "Name, monthly payment, gym_password, and location are required for the gym.",
      });
      return;
    }
    console.log(`Gym Password ${gym_password}`);

    try {
      const gym: Gym = {
        gym_name: gym_name,
        gym_monthly_payment: gym_monthly_payment,
        gym_location: gym_location,
        gym_password: gym_password,
        gym_image: gym_image,
      };
      const newGym: Gym | null = await gymStore.createGym(gym);

      if (newGym) {
        res.status(201).json({ message: "Success", data: newGym });
      } else {
        res.status(500).json({ error: "Failed to create the gym." });
      }
    } catch (error) {
      console.error("Error creating gym:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };

  static getAllGym = async (req: Request, res: Response): Promise<void> => {
    const gymStore: GymStore = new GymStore();

    try {
      const gyms: Gym[] = await gymStore.getAllGym();
      res.status(200).json({ message: "Success", data: gyms });
    } catch (error) {
      console.error("Error getting all gyms:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };

  static getGymUsers = async (req: Request, res: Response) => {
    const gymStore: GymStore = new GymStore();

    try {
      console.log("Get Gym User Executed");
      // Retrieve the gym ID from the route parameter
      const gym_id = parseInt(req.params.gym_id);
      // Check if gymId is a valid integer; if not, handle the error appropriately
      if (isNaN(gym_id)) {
        return res.status(400).json({ error: "Invalid gym ID" });
      }
      // Fetch gym users based on gymId
      const gymUser = await gymStore.getGymUsers(gym_id);
      res.status(200).json({ message: "Success", data: gymUser });
    } catch (error) {
      console.error("Error getting gym users:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };

  static gymLogin = async (req: Request, res: Response, next: Function) => {
    try {
      const gymStore: GymStore = new GymStore();
      const { gym_name, gym_password } = req.body;
      console.log(gym_name);
      console.log(gym_password);
      const token = await gymStore.gymLogin(gym_name, gym_password);
      if (token) {
        console.log(token);
        res.json({ message: "Success", data: token });
      } else {
        res
          .status(401)
          .json({ message: "error", error: `Invalid email or password` });
      }
    } catch (error) {
      return next(error);
    }
  };
  static getGymUserCount = async (req: Request, res: Response) => {
    const gymStore: GymStore = new GymStore();
    console.log(`User Count Excuted`);
    try {
      // Retrieve the gym ID from the route parameter
      const gym_id = parseInt(req.params.gym_id);
      // Check if gymId is a valid integer; if not, handle the error appropriately
      if (isNaN(gym_id)) {
        return res.status(400).json({ error: "Invalid gym ID" });
      }
      // Fetch the count of gym users based on gymId
      const userCount = await gymStore.countGymUsers(gym_id);
      console.log(`User Count ${userCount}`);
      res.status(200).json({ message: "Success", data: userCount });
    } catch (error) {
      console.error("Error getting gym user count:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
  static getGymProvider = async (req: Request, res: Response) => {
    const gymStore: GymStore = new GymStore();

    try {
      console.log("Get Gym Provider Executed");
      // Retrieve the gym ID from the route parameter
      const user_id = parseInt(req.params.user_id);
      // Check if gymId is a valid integer; if not, handle the error appropriately
      if (isNaN(user_id)) {
        return res.status(400).json({ error: "Invalid usr ID" });
      }
      // Fetch gym users based on gymId
      const gymProvider = await gymStore.getGymProvider(user_id);
      res.status(200).json({ message: "Success", data: gymProvider });
    } catch (error) {
      console.error("Error getting gym provider:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
  static getGymById = async (req: Request, res: Response, next: Function) => {
    try {
      const gymStore: GymStore = new GymStore();
      console.log(`GetGymById Executed: Gym Id ${req.params.id!}`);
      const gymWithId = await gymStore.getGymById(req.params.id!.toString());
      return res.json({ message: "Success", data: gymWithId });
    } catch (error) {
      return next(error);
    }
  };
}

export default GymController;
