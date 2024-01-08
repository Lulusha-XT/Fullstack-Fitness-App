import DB from "../configs/db.js";

class UserExerciseService {
  async userLikeExercise(user_id: number, exercise_id: number) {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO user_liked_exercise (user_id, exercise_id) VALUES($1,$2) RETURNING *";
      const result = await conn.query(sql, [user_id, exercise_id]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  async getAllUserLikeExercise() {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM user_liked_exercise";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
}

export default UserExerciseService;
