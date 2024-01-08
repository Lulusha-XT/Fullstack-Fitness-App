import { Request, Response, NextFunction } from "express";
import UserFoodService from "../services/user_food_service.js";

class UserFoodControllers {
  static userLikeFood = async (req: Request, res: Response) => {
    try {
      const userFoodService: UserFoodService = new UserFoodService();
      const userLikeFood = userFoodService.userLikeFood(
        req.body.user_id,
        req.body.food_id
      );
      res.json({ message: "Success", data: userLikeFood });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllUserLikeFood = async (req: Request, res: Response) => {
    try {
      const userFoodService: UserFoodService = new UserFoodService();
      const alluserLikedFood = await userFoodService.getAllUserLikeFood();
      res.json({ message: "Success", data: alluserLikedFood });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default UserFoodControllers;
