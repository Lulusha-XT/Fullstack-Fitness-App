import { MikroORM } from "@mikro-orm/core";
import { Options } from "@mikro-orm/postgresql";
import { User } from "../entity/user.entity.js";
import { Book } from "../entity/book.entity.js";
import { Exercise } from "../entity/exercise.entity.js";
import { Workout } from "../entity/workout.entity.js";
import { ExerciseCategory } from "../entity/exercis_ceategory.entity.js";

const config: Options = {
  entities: [User, Book, Exercise, Workout, ExerciseCategory],
  dbName: "fitness_db",
  type: "postgresql",
  user: "postgres",
  password: "tewodros",
  clientUrl: "postgresql://localhost:5432",
};

// Initialize MikroORM
const orm = await MikroORM.init(config);

const adminOptions = {
  resources: [
    {
      resource: { model: User, orm },
      options: {},
    },
    {
      resource: {
        model: Book,
        orm,
        options: {
          properties: {
            bookTitle: { type: "string" },
            bookDescription: { type: "text" },
            bookAuthorName: { type: "string" },
            bookThumbnail: {
              type: "file",
              columnType: "file", // Ensure you set the columnType to "file"
              isVisible: { list: true, show: true, edit: true },
              components: {
                edit: "admin-file-upload", // Use the admin-file-upload component to render a file upload component
                label: "Book Thumbnail", // The label of the file upload component
                accept: "image/*", // Only allow users to upload image files
              },
            },
            bookFilePath: {
              type: "file",
              columnType: "file", // Ensure you set the columnType to "file"
              isVisible: { list: true, show: true, edit: true },
              components: {
                edit: "admin-file-upload", // Use the admin-file-upload component to render a file upload component
                label: "Book File Path", // The label of the file upload component
                accept: "application/pdf", // Only allow users to upload PDF files
              },
            },
          },
        },
      },
    },
    {
      resource: { model: Exercise, orm },
      options: {},
    },
    {
      resource: { model: Workout, orm },
      options: {},
    },
    {
      resource: { model: ExerciseCategory, orm },
      options: {},
    },
  ],
};

export default adminOptions;
