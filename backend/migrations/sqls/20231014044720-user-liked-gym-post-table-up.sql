CREATE TABLE user_liked_gym_post (
  user_id INTEGER REFERENCES users(user_id),
  gym_post_id INTEGER REFERENCES gym_post(id),
  PRIMARY KEY (user_id, gym_post_id)
);