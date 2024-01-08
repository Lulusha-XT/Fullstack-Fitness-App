import DB from "../configs/db.js";

export type GymPost = {
  id?: number;
  gym_id: number;
  post_description: string;
  post_image_path: string;
};

export class GymPostStore {
  async createGymPost(gymPost: GymPost): Promise<GymPost> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO gym_post (gym_id, post_description, post_image_path) VALUES($1,$2,$3) RETURNING *";
      const result = await conn.query(sql, [
        gymPost.gym_id,
        gymPost.post_description,
        gymPost.post_image_path,
      ]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`Could not create gym post  ${err}`);
    }
  }
  async getAllGymPost(): Promise<GymPost> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM gym_post";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
  async getAllGymPostByGymId(gym_id: number): Promise<GymPost> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM gym_post WHERE gym_id = $1";
      const result = await conn.query(sql, [gym_id]);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
  async userLikeGymPost(user_id: number, gym_post_id: number) {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO user_liked_gym_post (user_id, gym_post_id) VALUES($1,$2) RETURNING *";
      const result = await conn.query(sql, [user_id, gym_post_id]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  getLikeGymPostsByUserId = async (gym_id: number): Promise<GymPost[]> => {
    try {
      console.log(`Get Like Gym Post By User Id Excuted user id = ${gym_id}`);
      const conn = await DB.connect();
      const sql = `
      SELECT p.*
      FROM gym_post p
      INNER JOIN user_liked_gym_post l ON p.id = l.gym_post_id
      WHERE l.user_id = $1
    `;
      const result = await conn.query(sql, [gym_id]);
      conn.release();
      return result.rows;
    } catch (error) {
      console.error("Error geting gym post:", error);
      return [];
    }
  };
  // async getLikeGymPostsByUserId(user_id: number) {
  //   try {
  //     const conn = await DB.connect();
  //     const sql = `
  //     SELECT p.*
  //     FROM gym_post p
  //     INNER JOIN user_liked_gym_post l ON p.id = l.gym_post_id
  //     WHERE l.user_id = $1
  //   `;
  //     // const sql = "SELECT * FROM user_liked_gym_post WHERE user_id = $1";
  //     const result = await conn.query(sql, [user_id]);
  //     conn.release();
  //     if (!result) throw new Error("Post not found");
  //     // Throw an error if the user is not found
  //     console.log(`DAta ${result.rows.id}`);
  //     return result.rows;
  //   } catch (err) {
  //     throw new Error(`Could not select ${err} `);
  //   }
  // }
}
