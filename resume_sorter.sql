
-- SQL Smart Resume Sorter Project

CREATE DATABASE resume_sorter;
USE resume_sorter;

CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY,
    name VARCHAR(100),
    experience INT,
    location VARCHAR(100)
);

CREATE TABLE candidate_skills (
    skill_id INT PRIMARY KEY,
    candidate_id INT,
    skill VARCHAR(100),
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id)
);

INSERT INTO candidates VALUES
(1, 'Aarav Mehta', 2, 'Pune'),
(2, 'Shruti Sharma', 1, 'Hyderabad'),
(3, 'Rohan Deshmukh', 3, 'Mumbai'),
(4, 'Ananya Gupta', 2, 'Bangalore');

INSERT INTO candidate_skills VALUES
(1, 1, 'SQL'),
(2, 1, 'Python'),
(3, 1, 'AWS'),
(4, 2, 'Python'),
(5, 2, 'HTML'),
(6, 2, 'CSS'),
(7, 3, 'SQL'),
(8, 3, 'Java'),
(9, 3, 'DSA'),
(10, 4, 'SQL'),
(11, 4, 'Python'),
(12, 4, 'Machine Learning');

CREATE TABLE required_skills (
    skill VARCHAR(100)
);

INSERT INTO required_skills VALUES
('SQL'), ('Python'), ('AWS');

-- Ranking Query
SELECT 
    c.name,
    COUNT(cs.skill) AS matched_skills,
    c.experience,
    c.location
FROM candidates c
LEFT JOIN candidate_skills cs 
       ON c.candidate_id = cs.candidate_id
       AND cs.skill IN (SELECT skill FROM required_skills)
GROUP BY c.name, c.experience, c.location
ORDER BY matched_skills DESC, c.experience DESC;
