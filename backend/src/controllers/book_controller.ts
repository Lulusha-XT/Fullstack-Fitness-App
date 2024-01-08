import { Request, Response, Router } from "express";
import { Book, BookCategory, BookStore } from "../models/book.js";

class BookController {
  static createNewBookCategory = async (req: Request, res: Response) => {
    try {
      const bookStore: BookStore = new BookStore();
      const bookCategory: BookCategory = {
        category_name: req.body.category_name,
      };
      const newBookCategory = await bookStore.createBookCategory(bookCategory);
      res.json({ message: "Success", data: newBookCategory });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllBookCategories = async (
    req: Request,
    res: Response
  ): Promise<void> => {
    try {
      const bookStore: BookStore = new BookStore();
      const allBookCategories = await bookStore.getAllBookCategories();
      res.json({ message: "Success", data: allBookCategories });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static createNewBook = async (req: Request, res: Response): Promise<void> => {
    try {
      const bookStore: BookStore = new BookStore();

      // Handle multiple files using 'req.files' instead of 'req.file'
      const bookFiles: Express.Multer.File[] =
        req.files as Express.Multer.File[];

      // Assuming you want to use the first uploaded file as the thumbnail
      const thumbnailPath: string =
        bookFiles.length > 0 ? bookFiles[0].path.replace(/\\/g, "/") : "";

      // Assuming you want to use the second uploaded file as the book file path
      const bookFilePath: string =
        bookFiles.length > 1 ? bookFiles[1].path.replace(/\\/g, "/") : "";
      console.log(bookFiles[1]);
      const book: Book = {
        book_title: req.body.book_title,
        book_description: req.body.book_description,
        book_thumbnail: thumbnailPath,
        book_file_path: bookFilePath,
        book_category_id: req.body.book_category_id,
        book_author_name: req.body.book_author_name,
      };

      console.log(book);
      const newBook = await bookStore.createBook(book);
      res.json({ message: "success", data: newBook });
    } catch (err) {
      res.status(400).json({ message: "error", error: `${err}` });
    }
  };

  static getAllBook = async (req: Request, res: Response): Promise<void> => {
    try {
      const bookStore: BookStore = new BookStore();
      const allBook = await bookStore.getAllBooks();
      res.json({ message: "Success", data: allBook });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default BookController;
