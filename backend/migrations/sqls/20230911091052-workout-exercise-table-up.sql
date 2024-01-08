CREATE TABLE workout_exercise (
  workout_id INTEGER REFERENCES workouts(workout_id),
  exercise_id INTEGER REFERENCES exercises(exercise_id),
  PRIMARY KEY (workout_id, exercise_id)
);