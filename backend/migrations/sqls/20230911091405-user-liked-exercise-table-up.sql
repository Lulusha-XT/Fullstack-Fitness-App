CREATE TABLE user_liked_exercise (
  user_id INTEGER REFERENCES users(user_id),
  exercise_id INTEGER REFERENCES exercises(exercise_id),
  PRIMARY KEY (user_id, exercise_id)
);