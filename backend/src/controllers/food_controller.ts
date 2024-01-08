import { Request, Response } from "express";
import { Food, FoodStore } from "../models/food.js";

class FoodController {
  static createNewFood = async (req: Request, res: Response) => {
    try {
      const foodStore: FoodStore = new FoodStore();
      const food: Food = {
        food_name: req.body.food_name,
        food_carbohydrate: req.body.food_carbohydrate,
        food_proten: req.body.food_proten,
        food_fat: req.body.food_fat,
        isSeasoning: req.body.isSeasoning,
      };
      const newFood = await foodStore.createFood(food);
      res.json(newFood);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllBookCategories = async (
    req: Request,
    res: Response
  ): Promise<void> => {
    try {
      const foodStore: FoodStore = new FoodStore();
      const allFood = await foodStore.getAllFood();
      res.json(allFood);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default FoodController;
