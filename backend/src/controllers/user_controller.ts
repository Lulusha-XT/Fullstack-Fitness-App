import { Request, Response, NextFunction } from "express";
import { User, UserStore } from "../models/user.js";
import { IRequest } from "../middleware/auth.js";
import transporter from "../configs/emailConfig.js";

class UserController {
  static createNewUser = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const user: User = {
        full_name: req.body.full_name,
        gender: req.body.gender,
        age: req.body.age,
        email: req.body.email,
        phone_number: req.body.phone_number,
        user_password: req.body.user_password,
      };
      if (
        !user.full_name ||
        !user.gender ||
        !user.age ||
        !user.email ||
        user.phone_number ||
        user.user_password
      ) {
        res.status(400).json({
          error:
            "Full Name, Gender, Age, Email, Phone Number and Password are required for the registration.",
        });
        return;
      }

      const newUser = await userStore.createUser(user);
      const mailOptions = {
        from: "tewodrosm01@email.com",
        to: user.email,
        subject: newUser.email,
        text: "Wellcome",
      };
      await transporter.sendMail(mailOptions);

      res.json({ message: "Success", data: newUser });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };

  static getAllUser = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const allUser = await userStore.getAllUsers();
      res.json(allUser);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };

  static userLogin = async (req: Request, res: Response, next: Function) => {
    try {
      const userStore: UserStore = new UserStore();
      const { email, password } = req.body;
      console.log(email);
      console.log(password);
      const token = await userStore.userLogin(email, password);
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

  static updateUserById = async (
    req: IRequest,
    res: Response,
    next: NextFunction
  ) => {
    try {
      console.log("Update UserById Executed");
      console.log("Req User", req.user);
      const userStore: UserStore = new UserStore();
      // Handle optional profile picture path
      const profile_picture_path = req.file?.path?.replace(/\\/g, "/") || "";
      console.log(`Profile Picture: ${profile_picture_path}`);
      // Extract data from the request body
      const id = req.user?.user_id;
      const user: User = {
        full_name: req.body.full_name,
        gender: req.body.gender,
        birthday: req.body.birthday,
        height: parseInt(req.body.height),
        weight: parseInt(req.body.weight),
        email: req.body.email,
        phone_number: req.body.phone_number,
        aim: req.body.aim,
        activity_extent: req.body.activity_extent,
        profile_picture: profile_picture_path,
      };
      // Calculate the age from the birthday
      if (user.birthday) {
        console.log(`User birthday: Excuted${user.birthday}`);
        const birthDate = new Date(user.birthday);
        const today = new Date();
        const ageInMillis = today.getTime() - birthDate.getTime();
        const ageInYears = Math.floor(
          ageInMillis / (365.25 * 24 * 60 * 60 * 1000)
        ); // Assuming a year has 365.25 days on average
        user.age = ageInYears;
      }

      if (!id) {
        res.status(400).json({
          error: "User ID are required.",
        });
        return;
      }
      if (
        !user.full_name ||
        !user.gender ||
        !user.age ||
        !user.email ||
        user.phone_number ||
        user.user_password
      ) {
        res.status(400).json({
          error:
            "Full Name, Gender, Age, Email, Phone Number and Password are required for the update.",
        });
        return;
      }
      const result = await userStore.updateUserById(id!, user);
      return res.json({ message: "Success", data: result });
    } catch (error) {
      return next(error); // Pass the error to the next error handling middleware
    }
  };

  static getUserById = async (req: Request, res: Response, next: Function) => {
    try {
      const userStore: UserStore = new UserStore();
      console.log("GetUserById Executed");
      const userWithId = await userStore.getUserById(req.params.id!.toString());
      return res.json({ message: "Success", data: userWithId });
    } catch (error) {
      return next(error);
    }
  };
}

export default UserController;
