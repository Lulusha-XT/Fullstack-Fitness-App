CREATE TABLE gym (
  gym_id SERIAL PRIMARY KEY,
  gym_name VARCHAR(255) NOT NULL,
  gym_monthly_payment DECIMAL(10, 2),
  gym_location VARCHAR(255) NOT NULL,
  gym_password  VARCHAR(100) NOT NULL,
  gym_image VARCHAR(255)
);
