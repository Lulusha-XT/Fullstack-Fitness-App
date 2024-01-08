import bcrypt from "bcrypt";
import dotenv from "dotenv";
import DB from "../configs/db.js";
import * as auth from "../middleware/auth.js";

dotenv.config();
const pepper: any = process.env.BCRYPT_PASSWORD;
const saltRound: any = process.env.SALT_ROUNDS;

export type User = {
  user_id?: number;
  full_name: string;
  gender: string;
  birthday?: string;
  age?: number;
  height?: number;
  weight?: number;
  email: string;
  phone_number: string;
  aim?: string;
  activity_extent?: string;
  user_password?: string;
  profile_picture?: string;
  token?: string;
  join_date?: string; // Add the join_date field
};

export class UserStore {
  async createUser(user: User): Promise<User> {
    try {
      const conn = await DB.connect();

      // Check if the email already exists
      const emailExistsQuery = "SELECT email FROM users WHERE email = $1";
      const emailExistsResult = await conn.query(emailExistsQuery, [
        user.email,
      ]);

      if (emailExistsResult.rows.length > 0) {
        conn.release();
        throw new Error("Email already exists");
      }

      const sql =
        "INSERT INTO users (full_name, gender, age, height, weightt, email, phone_number, user_password) VALUES($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *";
      const hash = bcrypt.hashSync(
        user.user_password + pepper,
        parseInt(saltRound)
      );
      const result = await conn.query(sql, [
        user.full_name,
        user.gender,
        user.age,
        user.height,
        user.weight,
        user.email,
        user.phone_number,
        hash,
      ]);
      conn.release();

      const newUser: User = result.rows[0];
      const token = auth.assignAccessToken(newUser);
      console.log(token);
      // Update user token and save
      newUser.token = token;
      return newUser;
    } catch (err) {
      throw new Error(`Could not create user ${err}`);
    }
  }

  async getAllUsers(): Promise<User> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM users";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Colud not select ${err}`);
    }
  }

  async userLogin(email: string, password: string) {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM users WHERE email = $1";
      const result = await conn.query(sql, [email]);
      const user: User = result.rows[0];
      conn.release();
      if (
        user &&
        (await bcrypt.compare(password + pepper, user.user_password!))
      ) {
        const token = auth.assignAccessToken(user);
        console.log(token);
        // Update user token and save
        user.token = token;
        return user;
      }
      return null;
    } catch (error) {
      const errorData = { message: "Log in failed", error: error };
      return errorData;
    }
  }

  async updateUserById(id: number, user: User): Promise<User | null> {
    try {
      const conn = await DB.connect(); // Assuming DB.connect() returns a connection from the pool
      // Prepare the SQL query to update the user
      const sql =
        "UPDATE users SET full_name = $1, gender = $2, birthday = $3, age = $4, height = $5, weightt = $6, email = $7, phone_number = $8, aim = $9, activity_extent = $10, profile_picture = $11 WHERE user_id = $12 RETURNING *";
      // Execute the update query and await the result
      const result = await conn.query(sql, [
        user.full_name,
        user.gender,
        user.birthday,
        user.age,
        user.height,
        user.weight,
        user.email,
        user.phone_number,
        user.aim,
        user.activity_extent,
        user.profile_picture,
        id, // This may be undefined if no profile_picture is provided
      ]);

      // If a row was affected, return the updated user, otherwise return null
      if (result.rowCount > 0) {
        return result.rows[0];
      } else {
        return null;
      }
    } catch (error) {
      throw error;
    }
  }

  async getUserById(id: string): Promise<User> {
    try {
      const conn = await DB.connect();
      // Find the user by ID
      const sql = "SELECT * FROM users WHERE user_id = $1";
      const result = await conn.query(sql, [id]);
      conn.release();
      if (!result) throw new Error("User not found"); // Throw an error if the user is not found
      return result.rows[0]; // Return the user if it exists
    } catch (error) {
      throw new Error(`Retrieving user failed: ${error}`);
    }
  }

  async updateUserJoinDate(
    userId: number,
    newJoinDate: Date
  ): Promise<boolean> {
    try {
      const conn = await DB.connect();
      const sql = "UPDATE users SET join_date = $1 WHERE id = $2";
      const result = await conn.query(sql, [newJoinDate, userId]);
      conn.release();
      return result.rowCount > 0;
    } catch (error) {
      console.error("Error updating user join date:", error);
      return false;
    }
  }
}
