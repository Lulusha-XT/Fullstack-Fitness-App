import express from "express";
import * as UploadController from "../controllers/uploadController.js";
import path from "path";
import { fileURLToPath } from "url";
import { dirname } from "path";
import multer from "multer";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const uploadsPath = path.join(__dirname, "../uploads");
const upload = multer({ dest: uploadsPath });
upload.single("bookFilePath");

const bookRouter: express.Router = express();
bookRouter.post(
  "/",
  upload.single("bookFilePath"),
  UploadController.uploadController
);

export default bookRouter;
