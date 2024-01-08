import DB from "../configs/db.js";
import { User } from "../models/user.js";

class UserGymService {
  async getAllUsersNotPaid(): Promise<User[]> {
    try {
      const conn = await DB.connect();
      const sql = `
            SELECT u.*
            FROM users u
            JOIN user_gym_membership ugm ON u.user_id = ugm.user_id
            WHERE ugm.is_paid = false
          `;
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select users who have not paid: ${err}`);
    }
  }

  joinGym = async (userId: number, gymId: number, joinDate: Date) => {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO user_gym_membership (user_id, gym_id, join_date) VALUES ($1, $2, $3)";
      const result = await conn.query(sql, [userId, gymId, joinDate]);
      conn.release();
      return result.rowCount > 0;
    } catch (error) {
      console.error("Error joining gym:", error);
      return false;
    }
  };
  leaveGym = async (userId: number, gymId: number) => {};

  async updateUserPaymentStatus(
    userId: number,
    gymId: number,
    isPaid: boolean
  ): Promise<User | null | undefined> {
    try {
      const conn = await DB.connect(); // Assuming DB.connect() returns a connection from the pool
      // Prepare the SQL query to update the user's payment status in the user_gym_membership table
      const sql =
        "UPDATE user_gym_membership SET is_paid = $1 WHERE user_id = $2 AND gym_id = $3";
      // Execute the update query and await the result
      const result = await conn.query(sql, [isPaid, userId, gymId]);

      // If a row was affected, return the updated user
      if (result.rowCount > 0) {
        // You may want to fetch the user information here if needed
        // For example, retrieve the user's details from the "users" table
        const userSql = "SELECT * FROM users WHERE id = $1";
        const userResult = await conn.query(userSql, [userId]);

        if (userResult.rowCount > 0) {
          return userResult.rows[0];
        } else {
          console.error("Error retrieving user:");
        }
      }

      return null;
    } catch (error) {
      console.error("Error updating user payment status:", error);
      return null;
    }
  }
}

export default UserGymService;
