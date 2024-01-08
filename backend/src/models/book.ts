import DB from "../configs/db.js";

export type BookCategory = {
  id?: number;
  category_name: string;
};
export type Book = {
  book_id?: number;
  book_title: string;
  book_description: string;
  book_thumbnail: string;
  book_file_path: string;
  book_author_name: string;
  book_category_id?: number;
};

export class BookStore {
  async createBookCategory(bookCategory: BookCategory): Promise<BookCategory> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO book_category (category_name) VALUES($1) RETURNING *";
      const result = await conn.query(sql, [bookCategory.category_name]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`Could not create book category ${err}`);
    }
  }
  async getAllBookCategories(): Promise<Book> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM book_category";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
  async createBook(book: Book): Promise<Book> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO books (book_title ,book_description,book_thumbnail,book_file_path,book_author_name,book_category_id) VALUES($1,$2,$3,$4,$5,$6) RETURNING *";
      const result = await conn.query(sql, [
        book.book_title,
        book.book_description,
        book.book_thumbnail,
        book.book_file_path,
        book.book_author_name,
        book.book_category_id,
      ]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`Could not create book ${err}`);
    }
  }
  async getAllBooks(): Promise<Book> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM books";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select books ${err} `);
    }
  }
}
