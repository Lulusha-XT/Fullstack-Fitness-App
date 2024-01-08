import { Request, Response, NextFunction } from "express";
import jwt, { JwtPayload, Secret } from "jsonwebtoken";
import { User } from "../models/user.js";
import { Gym } from "../models/gym.js";
import dotenv from "dotenv";

dotenv.config();
const secret: Secret = process.env.TOKEN_SECRET as Secret;

interface DecodedTokenPayload extends JwtPayload {
  user: User;
}
export interface IRequest extends Request {
  user?: User;
  file?: Express.Multer.File; // Adjust the type based on your file object structure
}
const verifyToken = (req: IRequest, res: Response, next: NextFunction) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  console.log(token);

  if (!token) return res.status(403).send({ message: "No Token Provided" });

  try {
    const decodedToken = jwt.verify(token, secret) as User;
    console.log("Print Message", decodedToken);
    req.user = decodedToken;
    console.log("Req User Message", req.user);
    next();
  } catch (error) {
    res.status(401).send({ message: "Unauthorized" });
  }
};

const assignAccessToken = (user: User): string => {
  const expiresIn = "1h";
  const userObject = JSON.parse(JSON.stringify(user));
  return jwt.sign(userObject, secret, { expiresIn });
};
const assignAccessTokenToGym = (gym: Gym): string => {
  const expiresIn = "1h";
  const gymObject = JSON.parse(JSON.stringify(gym));
  return jwt.sign(gymObject, secret, { expiresIn });
};

export { verifyToken, assignAccessToken, assignAccessTokenToGym };
