CREATE DATABASE minions;
USE minions;
-- 1
CREATE TABLE minions (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT pk_minions PRIMARY KEY (id)
);
CREATE TABLE towns(
    town_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT pk_towns PRIMARY KEY (town_id)
);
-- 2
ALTER TABLE towns
RENAME COLUMN town_id TO id;
ALTER TABLE minions
ADD town_id INT;
ALTER TABLE minions
ADD CONSTRAINT fk_towns
FOREIGN KEY (town_id) REFERENCES towns(id);
--3
ALTER TABLE minions
MODIFY age INT NULL;
INSERT INTO towns(name)
VALUES 
('Sofia'),
('Plovdiv'),
('Varna');
INSERT INTO minions(name,age,town_id)
VALUES 
('Kevin',22,1),
('Bob',15,3),
('Steward',NULL,2);
--4
TRUNCATE TABLE minions;