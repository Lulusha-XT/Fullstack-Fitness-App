import DB from "../configs/db.js";

export type Workout = {
  id?: number;
  gym_id?: number;
  workout_name: string;
  workout_description: string;
};

export class WorkoutStore {
  async createWorkoutExcercise(workout_id: number, excersis_id: number) {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO workout_exercise(workout_id, exercise_id) VALUES($1,$2) RETURNING *";
      const result = await conn.query(sql, [workout_id, excersis_id]);
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  async getAllWorkoutExcercises(): Promise<Workout> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM workout_exercise";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
  async createWorkout(workout: Workout): Promise<Workout> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO workouts(workout_name, workout_description) VALUES($1,$2) RETURNING *";
      const result = await conn.query(sql, [
        workout.workout_name,
        workout.workout_description,
      ]);
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  async getAllWorkout(): Promise<Workout> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM workouts";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
}
