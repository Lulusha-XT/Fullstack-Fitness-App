import DB from "../configs/db.js";

export type ExerciseCategory = {
  id?: number;
  gym_id?: number;
  category_name: string;
};

export type Exercise = {
  id?: number;
  gym_id?: number;
  exercise_name: string;
  exercise_description: string;
  exercise_thumbnail: string;
  exercise_video_path: string;
  exercise_category_id: string;
};

export class ExerciseStore {
  async createExerciseCategory(
    exerciseCategory: ExerciseCategory
  ): Promise<ExerciseCategory> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO exercise_category(category_name) VALUES($1) RETURNING *";
      const result = await conn.query(sql, [exerciseCategory.category_name]);
      return result.rows[0];
    } catch (err) {
      throw new Error(`Could not create exercise ${err}`);
    }
  }
  async getAllExerciseCategories(): Promise<Exercise> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM exercise_category";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
  async createExercise(exercise: Exercise): Promise<Exercise> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO exercises(exercise_name, exercise_description ,exercise_thumbnail,exercise_video_path,exercise_category_id) VALUES($1,$2,$3,$4,$5) RETURNING *";
      const result = await conn.query(sql, [
        exercise.exercise_name,
        exercise.exercise_description,
        exercise.exercise_thumbnail,
        exercise.exercise_video_path,
        exercise.exercise_category_id,
      ]);
      conn.release();
      return result.rows[0];
    } catch (err) {
      throw new Error(`Could not create exercises ${err}`);
    }
  }
  async getAllExercises(): Promise<Exercise> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM exercises";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
}
