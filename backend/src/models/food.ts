import DB from "../configs/db.js";

export type Food = {
  id?: number;
  food_name: string;
  food_carbohydrate: number;
  food_proten: number;
  food_fat: number;
  isSeasoning: boolean;
};

export class FoodStore {
  async createFood(food: Food): Promise<Food> {
    try {
      const conn = await DB.connect();
      const sql =
        "INSERT INTO foods (food_name, food_carbohydrate, food_proten, food_fat, isSeasoning) VALUES($1,$2,$3,$4,$5) RETURNING *";
      const result = await conn.query(sql, [
        food.food_name,
        food.food_carbohydrate,
        food.food_proten,
        food.food_fat,
        food.isSeasoning,
      ]);
      return result.rows[0];
    } catch (err) {
      throw new Error(`${err}`);
    }
  }
  async getAllFood(): Promise<Food> {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM foods";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (err) {
      throw new Error(`Could not select ${err} `);
    }
  }
}
