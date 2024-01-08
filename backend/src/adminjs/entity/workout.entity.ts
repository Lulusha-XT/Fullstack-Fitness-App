import { v4 } from "uuid";
import { BaseEntity, Entity, PrimaryKey, Property } from "@mikro-orm/core";

export interface IWorkout {
  workoutName: string;
  workoutDescription: string;
}

@Entity({ tableName: "workouts" })
export class Workout
  extends BaseEntity<Workout, "Workout_id">
  implements IWorkout
{
  @PrimaryKey({ columnType: "uuid" })
  Workout_id = v4();

  @Property({ fieldName: "workout_name", columnType: "text" })
  workoutName!: string;

  @Property({ fieldName: "workout_description", columnType: "text" })
  workoutDescription!: string;
}
