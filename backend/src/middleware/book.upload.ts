import { Request } from "express";
import multer from "multer";
import { v4 } from "uuid";
import path from "path";

const storage = multer.diskStorage({
  destination: "./uploads/book",
  filename: (_, file, cb) => {
    cb(null, v4() + path.extname(file.originalname));
  },
});

const fileFilter = (
  req: Request,
  file: Express.Multer.File,
  callback: Function
): void => {
  const acceptableExt = [".pdf", ".png", ".jpg", ".jpeg"];
  if (!acceptableExt.includes(path.extname(file.originalname))) {
    return callback(
      new Error("Only .pdf, .png, .jpg, and .jpeg format allowed!"),
      false
    );
  }
  const fileSize: number = parseInt(req.headers["content-length"] as string);

  if (fileSize > 104857600) {
    return callback(
      new Error("File size too big. Max size allowed is 100 MB."),
      false
    );
  }
  callback(null, true);
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 104857600, // 100 MB in bytes
  },
});

export default upload;
