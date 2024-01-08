import DB from "../configs/db.js";

class UserBookService {
  async userLikeBook(user_id: number, book_id: number) {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO user_book_interaction (user_id, book_id) VALUES($1,$2) RETURNING *";
      const result = await conn.query(sql, [user_id, book_id]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  async getAllUserLikeBook() {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM user_book_interaction";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
}

export default UserBookService;
