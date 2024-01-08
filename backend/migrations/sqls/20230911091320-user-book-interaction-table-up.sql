CREATE TABLE user_book_interaction (
  user_id INTEGER REFERENCES users(user_id),
  book_id INTEGER REFERENCES books(book_id),
  PRIMARY KEY (user_id, book_id)
);