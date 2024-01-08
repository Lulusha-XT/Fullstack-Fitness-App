import { v4 } from "uuid";
import { BaseEntity, Entity, PrimaryKey, Property } from "@mikro-orm/core";

export interface IUser {
  fullName: string;
  gender: string;
  age: number;
  height: number;
  weightt: number;
  email: string;
  phoneNumber: string;
  profilePicture: string;
  aim: string;
  activityExtent: string;
}

@Entity({ tableName: "users" })
export class User extends BaseEntity<User, "user_id"> implements IUser {
  @PrimaryKey({ columnType: "uuid" })
  user_id = v4();

  @Property({ fieldName: "full_name", columnType: "text" })
  fullName!: string;

  @Property({ fieldName: "gender", columnType: "text" })
  gender!: string;

  @Property({ fieldName: "age", columnType: "number" })
  age!: number;

  @Property({ fieldName: "height", columnType: "number" })
  height!: number;

  @Property({ fieldName: "weightt", columnType: "number" })
  weightt!: number;

  @Property({ fieldName: "email", columnType: "text" })
  email!: string;

  @Property({ fieldName: "phone_number", columnType: "text" })
  phoneNumber!: string;

  @Property({ fieldName: "profile_picture", columnType: "text" })
  profilePicture!: string;

  @Property({ fieldName: "aim", columnType: "text" })
  aim!: string;

  @Property({ fieldName: "activity_extent", columnType: "text" })
  activityExtent!: string;
}
