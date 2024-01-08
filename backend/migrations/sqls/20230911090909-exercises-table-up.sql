CREATE TABLE exercises (
  exercise_id SERIAL PRIMARY KEY,
  exercise_name VARCHAR(100) NOT NULL,
  exercise_description TEXT NOT NULL,
  exercise_thumbnail VARCHAR NOT NULL,
  exercise_video_path VARCHAR NOT NULL,
  exercise_category_id INTEGER REFERENCES exercise_category(exercise_category_id)
);