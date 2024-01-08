CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  gender VARCHAR(10)  NOT NULL,
  birthday VARCHAR(50),
  age INTEGER,
  height DOUBLE PRECISION,
  weightt DOUBLE PRECISION ,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  profile_picture VARCHAR,
  aim VARCHAR(255),
  activity_extent VARCHAR(255),
  user_password VARCHAR(255) NOT NULL
 );