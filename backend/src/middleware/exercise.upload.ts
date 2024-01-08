import { Request } from "express";
import multer from "multer";
import { v4 } from "uuid";
import path from "path";

const storage = multer.diskStorage({
  destination: "./uploads/workout",
  filename: (_, file, cb) => {
    cb(null, v4() + path.extname(file.originalname));
  },
});

const fileFilter = (
  req: Request,
  file: Express.Multer.File,
  callback: Function
): void => {
  const acceptableExt = [
    ".png",
    ".jpg",
    ".jpeg",
    ".mp4",
    ".avi",
    ".mov",
    ".wmv",
  ];
  if (!acceptableExt.includes(path.extname(file.originalname))) {
    return callback(
      new Error(
        "Only .png, .jpg, .jpeg, .mp4, .avi, .mov, and .wmv formats allowed!"
      ),
      false
    );
  }
  const fileSize: number = parseInt(req.headers["content-length"] as string);

  if (fileSize > 200 * 1024 * 1024) {
    return callback(
      new Error("File size too big. Max size allowed is 200 MB."),
      false
    );
  }

  callback(null, true);
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 200 * 1024 * 1024, // 200 MB in bytes
  },
});

export default upload;
