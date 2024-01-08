import { v4 } from "uuid";
import { BaseEntity, Entity, PrimaryKey, Property } from "@mikro-orm/core";

export interface IExerciseCategory {
  categoryName: string;
  exerciseCategoryThumbnailPath: string;
}

@Entity({ tableName: "exercise_category" })
export class ExerciseCategory
  extends BaseEntity<ExerciseCategory, "exercise_category_id">
  implements IExerciseCategory
{
  @PrimaryKey({ columnType: "uuid" })
  exercise_category_id = v4();

  @Property({ fieldName: "exercise_category_name", columnType: "text" })
  categoryName!: string;
  @Property({
    fieldName: "exercise_category_thumbnail_path",
    columnType: "text",
  })
  exerciseCategoryThumbnailPath!: string;
}
