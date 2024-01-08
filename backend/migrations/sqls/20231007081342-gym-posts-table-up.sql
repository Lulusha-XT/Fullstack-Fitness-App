CREATE TABLE gym_post (
    id SERIAL PRIMARY KEY,
    gym_id INT REFERENCES gym(gym_id),
    post_description VARCHAR(255) NOT NULL,
    post_image_path VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);