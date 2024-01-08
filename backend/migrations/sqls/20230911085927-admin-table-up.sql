CREATE TABLE admins (
  admin_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  user_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  admin_password VARCHAR(100) NOT NULL,
  admin_role VARCHAR(100)
);