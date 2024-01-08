// Book.ts
import { v4 } from "uuid";
import { BaseEntity, Entity, PrimaryKey, Property } from "@mikro-orm/core";

export interface IBook {
  bookTitle: string;
  bookDescription: string;
  bookAuthorName: string;
  bookThumbnail: string;
  bookFilePath: string;
}

@Entity({ tableName: "books" })
export class Book extends BaseEntity<Book, "book_id"> implements IBook {
  @PrimaryKey({ columnType: "uuid" })
  book_id = v4();

  @Property({ fieldName: "book_title", columnType: "text" })
  bookTitle!: string;

  @Property({ fieldName: "book_description", columnType: "text" })
  bookDescription!: string;

  @Property({ fieldName: "book_author_name", columnType: "text" })
  bookAuthorName!: string;

  @Property({ fieldName: "book_thumbnail", columnType: "file", type: "file" }) // Set the correct columnType to "file"
  bookThumbnail!: string;

  @Property({ fieldName: "book_file_path", columnType: "file", type: "file" }) // Set the correct columnType to "file"
  bookFilePath!: string;
}
