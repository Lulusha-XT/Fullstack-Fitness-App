import { v4 } from "uuid";
import { BaseEntity, Entity, PrimaryKey, Property } from "@mikro-orm/core";

export interface IExercise {
  exerciseName: string;
  exerciseDescription: string;
  exerciseThumbnail: string;
  exerciseVideoPath: string;
  exerciseCategoryId: string;
}

@Entity({ tableName: "exercises" })
export class Exercise
  extends BaseEntity<Exercise, "exercise_id">
  implements IExercise
{
  @PrimaryKey({ columnType: "uuid" })
  exercise_id = v4();

  @Property({ fieldName: "exercise_name", columnType: "text" })
  exerciseName!: string;

  @Property({ fieldName: "exercise_description", columnType: "text" })
  exerciseDescription!: string;

  @Property({ fieldName: "exercise_thumbnail", columnType: "text" })
  exerciseThumbnail!: string;

  @Property({ fieldName: "exercise_video_path", columnType: "text" })
  exerciseVideoPath!: string;

  @Property({ fieldName: "exercise_category_id", columnType: "upload" })
  exerciseCategoryId!: string;
}
