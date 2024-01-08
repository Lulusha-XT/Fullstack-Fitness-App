CREATE TABLE books (
  book_id SERIAL PRIMARY KEY,
  book_title  VARCHAR(255) NOT NULL,
  book_description TExT NOT NULL,
  book_thumbnail VARCHAR NOT NULL,
  book_file_path VARCHAR NOT NULL,
  book_author_name VARCHAR(255) NOT NULL,
  book_category_id INTEGER REFERENCES book_category(category_id)
);