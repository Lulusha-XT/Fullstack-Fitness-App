import express from "express";
import BookController from "../../controllers/book_controller.js";
import uploads from "../../middleware/book.upload.js";

const bookRouter: express.Router = express();
bookRouter.get("/", BookController.getAllBook);
bookRouter.post("/", uploads.array("book_files"), BookController.createNewBook);
bookRouter.get("/categories", BookController.getAllBookCategories);
bookRouter.post("/categories", BookController.createNewBookCategory);

export default bookRouter;
