CREATE TABLE user_gym_membership (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    gym_id INT REFERENCES gym(gym_id),
    join_date DATE NOT NULL,
    is_paid BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, gym_id)
);