import { Request, Response, NextFunction } from "express";
import { User, UserStore } from "../models/user.js";
import UserBookService from "../services/user_book_service.js";
import { IRequest } from "../middleware/auth.js";

class UserBookControllers {
  static userLikeBook = async (req: IRequest, res: Response) => {
    try {
      const userId = req.user?.user_id;
      if (!userId) {
        res.status(400).json({
          error: "userId are required for like book.",
        });
        return;
      }
      const userBookService: UserBookService = new UserBookService();
      const userLikeBook = userBookService.userLikeBook(
        req.body.user_id,
        req.body.exercise_id
      );
      res.json({ message: "Success", data: userLikeBook });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllUserLikeBook = async (req: Request, res: Response) => {
    try {
      const userBookService: UserBookService = new UserBookService();
      const alluserLikeExcercise = await userBookService.getAllUserLikeBook();
      res.json({ message: "Success", data: alluserLikeExcercise });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default UserBookControllers;
