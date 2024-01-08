import express, { Request, Response } from "express";

const errorHandler = (
  error: Error,
  _req: Request,
  res: Response,
  next: Function
) => {
  if (typeof error === "string") {
    // custom application error
    return res.status(400).json({ message: error });
  }

  if (error.name === "validationError") {
    // mongoose validation error
    return res.status(400).json({ message: error.message });
  }

  if (error.name === "UnauthorizationError") {
    // jwt authorization error
    return res.status(401).json({ message: error.message });
  }
  return res.status(500).json({ message: error.message });
};

export default errorHandler;
