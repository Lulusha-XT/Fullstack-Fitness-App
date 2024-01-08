CREATE TABLE user_likes_food (
  user_id INTEGER REFERENCES users(user_id),
  food_id INTEGER REFERENCES foods(food_id),
  PRIMARY KEY (user_id, food_id)
);