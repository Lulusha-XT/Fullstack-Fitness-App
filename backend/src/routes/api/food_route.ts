import express from "express";
import FoodController from "../../controllers/food_controller.js";

const foodRouter: express.Router = express();

foodRouter.get("/", FoodController.getAllBookCategories);
foodRouter.post("/", FoodController.createNewFood);

export default foodRouter;
