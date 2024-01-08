import DB from "../configs/db.js";

export type Trainer = {
  trainer_id?: number;
  gym_id?: number;
  trainer_name: number;
  trainer_profile_picture: number;
};

export class TrainerStore {
  async createTrainer(trainer: Trainer): Promise<Trainer> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO trainer (gym_id, trainer_name ,trainer_profile_picture ) VALUES($1, $2, $3) RETURNING *";
      const result = await conn.query(sql, [
        trainer.gym_id,
        trainer.trainer_name,
        trainer.trainer_profile_picture,
      ]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`Could not create trainer ${err}`);
    }
  }
}
