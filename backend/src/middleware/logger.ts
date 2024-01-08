import express, { Request, Response } from "express";

const logger = express();

logger.use((req: Request, _res: Response, next: Function) => {
  console.log(`${req.url}`);
  next();
});

export default logger;
