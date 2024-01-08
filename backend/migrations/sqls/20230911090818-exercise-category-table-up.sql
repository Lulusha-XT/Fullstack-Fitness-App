CREATE TABLE exercise_category (
  exercise_category_id SERIAL PRIMARY KEY,
  exercise_category_name VARCHAR(100) NOT NULL,
  exercise_category_thumbnail_path VARCHAR(255) NOT NULL
);