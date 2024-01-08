CREATE TABLE workouts (
  workout_id SERIAL PRIMARY KEY,
  workout_name VARCHAR(100) NOT NULL,
  workout_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);