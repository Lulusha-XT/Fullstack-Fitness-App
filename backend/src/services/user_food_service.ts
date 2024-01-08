import DB from "../configs/db.js";

class UserFoodService {
  async userLikeFood(user_id: number, food_id: number) {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO user_likes_food (user_id, food_id) VALUES($1,$2) RETURNING *";
      const result = await conn.query(sql, [user_id, food_id]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  async getAllUserLikeFood() {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM user_likes_food";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
}

export default UserFoodService;
