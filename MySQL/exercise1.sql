--Data-Definition-And-Datatypes-Exercises

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
-- 5
DROP TABLE minions;
DROP TABLE towns;
-- 6
USE minions;
CREATE TABLE people (
    id INT AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture VARBINARY(2048) NULL,
    height DECIMAL(3,2) NULL,
    weight DECIMAL(5,2) NULL,
    gender NVARCHAR(1),
    birthdate DATE NOT NULL,
    biography TEXT NULL,
    CONSTRAINT pk_people PRIMARY KEY (id),
    CONSTRAINT CK_gender CHECK (gender in ('m','f'))
);

ALTER TABLE people
MODIFY gender NVARCHAR(1) NOT NULL;

INSERT INTO people(name,picture,height,weight,gender,birthdate,biography)
VALUES 
('Kevin',NULL,0,0,'m','1967-09-22',NULL),
('Amy',NULL,0,0,'f','1967-07-02',NULL),
('Kevin',NULL,0,0,'m','1967-09-22',NULL),
('Amy',NULL,0,1.5,'f','1967-07-02',NULL),
('Kevin',NULL,0,0,'m','1967-09-22',NULL);
-- 7
USE minions;
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture VARBINARY(900) NULL,
    last_login_time DATETIME NOT NULL,
    is_deleted NVARCHAR(5),
    CONSTRAINT pk_username PRIMARY KEY (id),
    CONSTRAINT CK_active CHECK (is_deleted in ('true','false'))
);
INSERT INTO users(username,password,profile_picture,last_login_time,is_deleted)
VALUES 
('Kevin_1',1234567,NULL,'2009-09-22 06:55:47','true'),
('Amy_1',1234,NULL,'2009-09-22 08:50:47','false'),
('Kevin_2',1234567,NULL,'2009-09-22 06:55:47','false'),
('Amy_2',1234,NULL,'2009-09-22 08:50:47','true'),
('Kevin_3',123456789,NULL,'2020-09-22 01:00:44','false');
--8
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id,username);
--9
ALTER TABLE users
ALTER COLUMN last_login_time SET DEFAULT (current_timestamp);
--10
USE minions;
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users_id PRIMARY KEY (id);
ALTER TABLE users
ADD CONSTRAINT pk_unique UNIQUE(username);
--11
CREATE DATABASE Movies;
CREATE TABLE directors(
    dir_id INT AUTO_INCREMENT NOT NULL,
    director_name VARCHAR(100) NOT NULL,
    notes VARCHAR(100) NULL,
    CONSTRAINT pk_directors PRIMARY KEY (dir_id)
);
CREATE TABLE genres(
    gen_id INT AUTO_INCREMENT NOT NULL,
    genre_name VARCHAR(100) NOT NULL,
    notes VARCHAR(100) NULL,
    CONSTRAINT pk_genres PRIMARY KEY (gen_id)
);
CREATE TABLE categories(
    cat_id INT AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(100) NOT NULL,
    notes VARCHAR(100) NULL,
    CONSTRAINT pk_categories PRIMARY KEY (cat_id)
);
CREATE TABLE movies(
    movies_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(100) NOT NULL,
    director_id INT,
    copyright_year YEAR (4) NULL,
    length NVARCHAR(20) NULL,
    genre_id INT,
    category_id INT,
    rating INT NULL,
    notes VARCHAR(100) NULL,
    CONSTRAINT pk_movies PRIMARY KEY (movies_id),
    FOREIGN KEY (director_id) REFERENCES directors(dir_id),
    FOREIGN KEY (genre_id) REFERENCES genres(gen_id),
    FOREIGN KEY (category_id) REFERENCES categories(cat_id)
);
INSERT INTO directors (director_name)
VALUES ("Mike"), ("Smith"), ("Robert"), ("Samantha"), ("Angela");

INSERT INTO genres (genre_name)
VALUES ("Drama"), ("Horror"), ("Thriller"), ("Sci-Fi"), ("Action");

INSERT INTO categories (category_name)
VALUES ("For Kids"), ("Over 13"), ("Over 16"), ("Over 18"), ("No Restriction");

INSERT INTO movies (title)
VALUES ("Big Ben"), ("Suits"), ("Jurassic Park"), ("Andromeda"), ("Happy Hour");
--12
CREATE DATABASE car_rental;
CREATE TABLE car_categories(
    id INT AUTO_INCREMENT NOT NULL,
    category VARCHAR(100),
    daily_rate INT,
    weekly_rate INT,
    monthly_rate INT,
    weekend_rate INT,
    CONSTRAINT pk_categories_car PRIMARY KEY (id)
);
CREATE TABLE cars(
    id INT AUTO_INCREMENT NOT NULL,
    plate_number VARCHAR(10),
    make VARCHAR(50),
    model VARCHAR(50),
    car_year DATE,
    category_id INT,
    doors INT,
    picture VARBINARY(900),
    car_condition VARCHAR(100),
    available VARCHAR(50),
    CONSTRAINT pk_cars PRIMARY KEY (id)
);
CREATE TABLE employees(
    id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    title VARCHAR(50),
    notes VARCHAR(100),
    CONSTRAINT pk_employees PRIMARY KEY (id)
);
CREATE TABLE customers(
    id INT AUTO_INCREMENT NOT NULL,
    driver_licence_number VARCHAR(20),
    full_name VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(20),
    zip_code VARCHAR(20),
    notes VARCHAR(100),
    CONSTRAINT pk_customers PRIMARY KEY (id)
);
CREATE TABLE rental_orders(
    id INT AUTO_INCREMENT NOT NULL,
    employee_id INT, 
    customer_id INT, 
    car_id INT, 
    car_condition VARCHAR(100),
    tank_level INT, 
    kilometrage_start INT, 
    kilometrage_end INT, 
    total_kilometrage INT, 
    start_date DATE, 
    end_date DATE, 
    total_days INT, 
    rate_applied INT, 
    tax_rate INT, 
    order_status VARCHAR(50), 
    notes VARCHAR(100),
    CONSTRAINT pk_rental_orders PRIMARY KEY (id)
);
INSERT INTO car_categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES 
("First", 10, 20, 30, 40),
("Second", 100, 200, 300, 400),
("Third", 1000, 2000, 3000, 4000);
INSERT INTO cars (plate_number, make, model) 
VALUES 
("CA2341AB", "Toyota", "Supra"),
("CA1234AA", "Skoda", "Octavia"),
("CB9999CB", "Skoda", "Kamiq");
INSERT INTO employees (first_name, last_name)
VALUES
("John", "Doe"),
("Max", "Williams"),
("Jessica", "Roberts");
INSERT INTO customers (driver_licence_number, full_name)
VALUES
("21321312AA", "John Doe"),
("29A2938W99", "Marta Borg"),
("999ASD2222", "Max Smith");
INSERT INTO rental_orders (employee_id, customer_id, car_id)
VALUES
(1, 2, 3),
(3, 2, 1),
(2, 3, 1);
--13
CREATE DATABASE soft_uni;
CREATE TABLE towns(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100),
    CONSTRAINT pk_towns PRIMARY KEY (id)
);
CREATE TABLE addresses(
    id INT AUTO_INCREMENT NOT NULL,
    address_text VARCHAR(100),
    town_id INT,
    CONSTRAINT pk_addresses PRIMARY KEY (id),
    FOREIGN KEY (town_id) REFERENCES towns(id)
);
CREATE TABLE departments(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100),
    CONSTRAINT pk_departments PRIMARY KEY (id)
);
CREATE TABLE soft_uni_employees(
    id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(100), 
    middle_name VARCHAR(100), 
    last_name VARCHAR(100), 
    job_title VARCHAR(100), 
    department_id INT, 
    hire_date DATE, 
    salary DECIMAL(12,2), 
    address_id INT,
    CONSTRAINT pk_soft_uni_employees PRIMARY KEY (id),
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);
INSERT INTO towns(name)
VALUES 
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');
INSERT INTO departments(name)
VALUES 
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');
INSERT INTO employees(first_name,middle_name,last_name,job_title,department_id,hire_date,salary)
VALUES 
('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01',3500.00),
('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00),
('Maria','Petrova','Ivanova','Intern',5,'2016-08-28',525.25),
('Georgi','Terziev','Ivanov','CEO',2,'2007-12-09',3000.00),
('Peter','Pan','Pan','Intern',3,'2016-08-28',599.88);
--14
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM soft_uni_employees;
--15
SELECT * FROM towns ORDER BY name ASC;
SELECT * FROM departments ORDER BY name ASC;
SELECT * FROM soft_uni_employees ORDER BY salary DESC;
--16
SELECT name FROM towns ORDER BY name ASC;
SELECT name FROM departments ORDER BY name ASC;
SELECT first_name,last_name,job_title,salary FROM soft_uni_employees ORDER BY salary DESC;
--17
UPDATE soft_uni_employees SET salary=salary*1.1;
SELECT salary FROM soft_uni_employees;

--MySQL-Basic-CRUD-Exercises

SHOW TABLES FROM soft_uni;
--1
SELECT * FROM soft_uni.departments ORDER BY department_id ASC;
--2
SELECT name FROM departments;
--3
SELECT first_name, last_name, salary FROM employees ORDER BY employee_id;;
--4
SELECT first_name,middle_name, last_name FROM employees;
--5
SELECT CONCAT (first_name,".",last_name,"@softuni.bg") AS "full_ email_address" FROM employees;
--6
SELECT salary
FROM employees
GROUP BY salary
ORDER BY salary ASC;
--7
SELECT *
FROM employees
WHERE job_title="Sales Representative"
ORDER BY employee_id;
--8
SELECT first_name,last_name, job_title
FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id;
--9
SELECT 
CONCAT (first_name," ",middle_name," ",last_name) 
AS "Full Name"
FROM employees
WHERE salary=25000 OR salary=14000 OR salary=12500 OR salary=23600;
--10
SELECT first_name, last_name
FROM employees
WHERE manager_id is NULL;
--11
SELECT first_name,last_name, salary
FROM employees
WHERE salary >50000
ORDER BY salary DESC;
--12
SELECT first_name,last_name
FROM employees
ORDER BY salary DESC
LIMIT 5;
--13
SELECT first_name,last_name
FROM employees
WHERE department_id<>4;
--14
SELECT * FROM employees
ORDER BY salary DESC, first_name ASC,last_name DESC,middle_name ASC, employee_id ASC;
--15
CREATE VIEW v_employees_salaries AS
SELECT first_name,last_name,salary
FROM employees;
SELECT * FROM v_employees_salaries;
--16
CREATE VIEW v_employees_job_titles AS
--SELECT CONCAT_WS(" ", first_name, IF(middle_name = NULL , "", middle_name), last_name) AS "full_name", job_title FROM employees;
SELECT CONCAT_WS(" ", first_name, middle_name, last_name) AS "full_name", job_title
FROM employees;
--17
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title;
--18
SELECT *
FROM projects
ORDER BY start_date ASC, name ASC,project_id ASC
LIMIT 10;
--19
SELECT first_name,last_name,hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 7;
--20
UPDATE employees 
SET salary=salary*1.12
WHERE department_id=1 OR department_id=2 OR department_id=4 OR department_id=11;

SELECT DISTINCT (salary)
FROM employees
WHERE department_id=1 OR department_id=2 OR department_id=4 OR department_id=11;
--21
SELECT peak_name
FROM peaks
ORDER BY peak_name;
--22
SELECT country_name, population
FROM countries
WHERE continent_code="EU"
ORDER BY population DESC,country_name
LIMIT 30;
--23
SELECT country_name, country_code,
IF (currency_code="EUR","Euro","Not Euro") AS "currency"
FROM countries
ORDER BY country_name;
--24
SELECT name
FROM characters
ORDER BY name;