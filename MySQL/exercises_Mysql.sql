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

--CRUD

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

-- Built-in Functions

--1
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'sa%'
ORDER BY employee_id;
--2
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;
--3
SELECT first_name
FROM employees
WHERE (department_id=3 OR department_id=10) AND (hire_date BETWEEN '1995-01-01' AND '2005-12-31')
ORDER BY employee_id;
--4
SELECT first_name,last_name
FROM employees
WHERE job_title NOT LIKE'%engineer%'
ORDER BY employee_id;
--5
SELECT name
FROM towns
WHERE LENGTH(name) = 6 OR LENGTH(name) = 5
ORDER BY name;
--6
SELECT town_id,name
FROM towns
WHERE name LIKE 'M%' OR name LIKE'K%'OR name LIKE 'B%'OR name LIKE 'E%'
ORDER BY name;
--7
SELECT town_id,name
FROM towns
WHERE name NOT LIKE 'R%' AND name NOT LIKE'B%'AND name NOT LIKE 'D%'
ORDER BY name;
--8
CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name,last_name
FROM employees
WHERE YEAR(hire_date)>2000;
--9
SELECT first_name,last_name
FROM employees
WHERE LENGTH(last_name) = 5;
--10
SELECT country_name,iso_code
FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;
--11
SELECT peak_name, river_name, LOWER(CONCAT(LEFT(peak_name,length(peak_name)-1),river_name)) AS mix  
FROM peaks, rivers
WHERE RIGHT(peak_name,1)=LEFT(river_name,1)
ORDER BY mix;
--12
SELECT name,DATE(start)
FROM games
WHERE start BETWEEN '2011-01-01' AND '2012-12-31'
ORDER BY start ASC,name ASC
LIMIT 50;
--13
SELECT user_name,RIGHT(SUBSTR(email,LOCATE('@',email)), LENGTH(SUBSTR(email,LOCATE('@',email))) -1) AS email_provider
FROM users
ORDER BY email_provider ASC,user_name ASC;
--14
SELECT user_name,ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;
--15
SELECT name AS game, 
IF (HOUR(start)>=0 AND HOUR(start)<12,'Morning',IF(HOUR(start)>=12 AND HOUR(start)<18,'Afternoon','Evening')) AS Part_of_the_Day, 
IF(duration <= 3, 'Extra Short', IF(duration > 3 AND duration <= 6, 'Short',IF(duration > 6 AND duration <= 10, 'Long','Extra Long'))) AS Duration
FROM games;
--16
SELECT product_name,order_date, DATE_ADD(order_date,INTERVAL 3 DAY) AS pay_due,DATE_ADD(order_date,INTERVAL 1 MONTH) AS deliver_due
FROM orders;

--Exercises: Data Aggregation

--1
SELECT COUNT(id) 
AS "count"
FROM wizzard_deposits;
--2
SELECT MAX(magic_wand_size) 
AS "longest_magic_wand"
FROM wizzard_deposits;
--3
SELECT deposit_group, MAX(magic_wand_size) AS 'longest_magic_wand'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand ASC, deposit_group;
--4 - why only avg but no min
SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY avg(magic_wand_size)
LIMIT 1;
--5
SELECT deposit_group,
SUM (deposit_amount) AS 'total_sum'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum ASC;
--6
SELECT deposit_group,
SUM (deposit_amount) AS 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator='Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;
--7
SELECT deposit_group,
SUM (deposit_amount) AS 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator='Ollivander family'
GROUP BY deposit_group
HAVING SUM(deposit_amount)<150000
ORDER BY total_sum DESC;
--8
SELECT deposit_group,magic_wand_creator, MIN(deposit_charge) AS 'min_deposit_charge'
FROM wizzard_deposits
GROUP BY deposit_group,magic_wand_creator
ORDER BY magic_wand_creator,deposit_group;
--9
SELECT 
IF(age>=0 AND age<=10,'[0-10]',
IF(age>=11 AND age<=20,'[11-20]',
IF(age>=21 AND age<=30,'[21-30]',
IF(age>=31 AND age<=40,'[31-40]',
IF(age>=41 AND age<=50,'[41-50]',
IF(age>=51 AND age<=60,'[51-60]',
'[61+]')))))) AS 'age_group',
COUNT(id) AS 'wizard_count'
FROM wizzard_deposits
GROUP BY age_group
ORDER BY age_group ASC;
--10
SELECT LEFT(first_name,1) AS 'first_letter'
FROM wizzard_deposits
WHERE deposit_group='Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;
--11
SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS 'average_interest'
FROM wizzard_deposits
WHERE deposit_start_date>'1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC,is_deposit_expired;
--12 -- USE soft_uni;
SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE DATE(hire_date)>'2000-01-01'
GROUP BY department_id
HAVING department_id=2 OR department_id=5 OR department_id=7
ORDER BY department_id;
--13
CREATE TABLE avg_salary_dept AS 
SELECT department_id, salary
FROM employees
WHERE salary>30000;
DELETE 
FROM avg_salary_dept
WHERE manager_id=42;
UPDATE avg_salary_dept
SET salary=salary+5000
WHERE department_id=1;
SELECT department_id, AVG(salary) AS 'avg_salary' 
FROM avg_salary_dept
GROUP BY department_id
ORDER BY department_id;
--14
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id;
--15
SELECT COUNT(employee_id)
FROM employees
WHERE manager_id;
--16
SELECT department_id, salary
FROM (SELECT department_id,salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS ranked_salaries 
FROM employees 
GROUP BY department_id,salary) AS ranked_salaries_deptid
WHERE ranked_salaries=3
GROUP BY department_id,salary;
--17
SELECT first_name, last_name, department_id
FROM employees AS orig
WHERE salary > (
    SELECT AVG(salary)
    FROM employees AS copy
    WHERE orig.department_id = copy.department_id)
ORDER BY department_id, employee_id
LIMIT 10;
--18
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY department_id;

--Table Relations

--1
USE geography;
CREATE TABLE passports (
    passports_id INT UNIQUE NOT NULL,
    passport_number VARCHAR(20) UNIQUE NOT NULL,
    PRIMARY KEY(passports_id)
    );
CREATE TABLE people (
    person_id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(200),
    salary DECIMAL(8,2),
    passport_id INT UNIQUE,
    PRIMARY KEY (person_id),
    FOREIGN KEY (passport_id) REFERENCES passports(passports_id)
);
INSERT INTO passports(passports_id,passport_number)
VALUES 
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2');
INSERT INTO people(first_name,salary,passport_id)
VALUES 
("Roberto",43300,102),
("Tom",56100,103),
("Yana",60200,101);

--2
CREATE TABLE manufacturers (
    manufacturers_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL,
    established_on DATE,
    PRIMARY KEY(manufacturers_id)
    );
CREATE TABLE models (
    model_id INT UNIQUE NOT NULL,
    name VARCHAR(50),
    manufacturer_id INT,
    PRIMARY KEY (model_id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturers_id)
);
INSERT INTO manufacturers(name,established_on)
VALUES 
("BMW",'1916-03-01'),
("Tesla",'2003-01-01'),
("Lada",'1966-05-01');
INSERT INTO models(model_id,name,manufacturer_id)
VALUES 
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);

--3
CREATE TABLE students (
    students_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(students_id)
    );
CREATE TABLE exams (
    exams_id INT UNIQUE,
    name VARCHAR(50),
    PRIMARY KEY (exams_id)
);
CREATE TABLE students_exams (
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    CONSTRAINT pk_students_exams PRIMARY KEY (student_id,exam_id),
    CONSTRAINT fk_students_ids FOREIGN KEY (student_id) REFERENCES students(students_id),
    CONSTRAINT fk_exams_ids FOREIGN KEY (exam_id) REFERENCES exams(exams_id)
);
INSERT INTO students(name)
VALUES 
('Mila'),
('Toni'),
('Ron');
INSERT INTO exams(exams_id,name)
VALUES 
(101,'Spring MVC'),
(102,'Neo4j'),
(103,'Oracle 11g');
INSERT INTO students_exams(student_id,exam_id)
VALUES 
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);

--4
CREATE TABLE teachers (
    teacher_id INT,
    name VARCHAR(50),
    manager_id INT,
    CONSTRAINT pk_teacher_id PRIMARY KEY (teacher_id)
);
INSERT INTO teachers (teacher_id, name, manager_id)
VALUES
(101, "John", NULL),
(102, "Maya", 106),
(103, "Silvia", 106),
(104, "Ted", 105),
(105, "Mark", 101),
(106, "Greta", 101);
ALTER TABLE teachers
ADD CONSTRAINT fk_teachers FOREIGN KEY (manager_id) REFERENCES teachers (teacher_id);

--5
CREATE TABLE item_types (
    item_type_id INT (11) NOT NULL,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_item_types PRIMARY KEY (item_type_id)
);
CREATE TABLE cities (
    city_id INT (11),
    name VARCHAR(50),
    CONSTRAINT pk_cities PRIMARY KEY (city_id)
);
CREATE TABLE items (
    item_id INT (11),
    name VARCHAR(50),
    item_type_id INT (11),
    CONSTRAINT pk_items PRIMARY KEY (item_id),
    CONSTRAINT fk_types FOREIGN KEY (item_type_id) REFERENCES item_types(item_type_id)
);
CREATE TABLE customers (
    customer_id INT (11),
    name VARCHAR(50),
    birthday DATE,
    city_id INT (11),
    CONSTRAINT pk_customers PRIMARY KEY (customer_id),
    CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES cities(city_id)
);
CREATE TABLE orders (
    order_id INT (11),
    customer_id INT (11),
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_id INT (11),
    item_id INT (11),
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, item_id),
    CONSTRAINT fk_order_ids FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT fk_items FOREIGN KEY (item_id) REFERENCES items (item_id)
);
--6
CREATE TABLE majors (
    major_id INT (11) NOT NULL,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_major PRIMARY KEY (major_id)
);
CREATE TABLE students (
    student_id INT (11) NOT NULL,
    student_number VARCHAR(12) NOT NULL,
    student_name VARCHAR(50) NOT NULL,
    major_id INT(11),
    CONSTRAINT pk_students_id PRIMARY KEY (student_id),
    CONSTRAINT fk_major_id FOREIGN KEY (major_id) REFERENCES majors(major_id)
);
CREATE TABLE payments (
    payment_id INT (11) NOT NULL,
    payment_date DATE,
    payment_amount DECIMAL (8,2),
    student_id INT (11),
    CONSTRAINT pk_payments PRIMARY KEY (payment_id),
    CONSTRAINT fk_students_id FOREIGN KEY (student_id) REFERENCES students(student_id)
);
CREATE TABLE subjects (
    subject_id INT (11) NOT NULL,
    subject_name VARCHAR (50),
    CONSTRAINT pk_subjects_id PRIMARY KEY (subject_id)
);
CREATE TABLE agenda (
    student_id INT (11),
    subject_id INT (11),
    CONSTRAINT pk_agenda PRIMARY KEY (student_id, subject_id),
    CONSTRAINT fk_agenda_student_id FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_agenda_subject_id FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);
--9
SELECT mountains.mountain_range,peaks.peak_name,peaks.elevation 
FROM peaks
INNER JOIN mountains ON peaks.mountain_id=mountains.id
WHERE mountain_range='Rila'
ORDER BY elevation DESC;

--Subqueries and JOINs

--1
SELECT e.employee_id,e.job_title,e.address_id,a.address_text
FROM employees
INNER JOIN addresses ON e.address_id=a.address_id
ORDER BY address_id
LIMIT 5;
--2
SELECT employees.first_name, employees.last_name, towns.name,addresses.address_text
FROM addresses
JOIN towns ON addresses.town_id=towns.town_id
JOIN employees ON addresses.address_id=employees.address_id
ORDER BY first_name,last_name
LIMIT 5;
--3
SELECT employees.employee_id,employees.first_name, employees.last_name, departments.name
FROM employees
JOIN departments ON employees.department_id_id=departments.department_id
WHERE name='Sales'
ORDER BY employee_id DESC;
--4
SELECT employees.employee_id,employees.first_name, employees.salary, departments.name
FROM employees
JOIN departments ON employees.department_id=departments.department_id
WHERE salary>15000
ORDER BY employees.department_id DESC
LIMIT 5;
--5
SELECT e.employee_id, e.first_name
FROM employees AS e
LEFT JOIN employees_projects AS ep
ON ep.employee_id = e.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;
--6
SELECT e.first_name,e.last_name,e.hire_date,d.name
FROM employees AS e
LEFT JOIN departments AS d
ON d.department_id = e.department_id
WHERE (e.hire_date>'1999-01-01') AND (d.name='Sales' OR d.name='Finance')
ORDER BY e.hire_date;
--7
SELECT e.employee_id, e.first_name,p.name AS 'project_name'
FROM employees AS e
JOIN employees_projects AS ep
ON ep.employee_id=e.employee_id
JOIN projects AS p
ON ep.project_id=p.project_id
WHERE DATE(p.start_date) > '2002-08-13' AND p.end_date IS NULL
ORDER BY e.first_name,p.name
LIMIT 5;
--8
SELECT e.employee_id, e.first_name, 
IF(p.start_date>='2005-01-01','NULL',p.name) AS 'project_name'
FROM employees AS e
JOIN employees_projects AS ep
ON ep.employee_id=e.employee_id
JOIN projects AS p
ON ep.project_id=p.project_id
WHERE e.employee_id=24
ORDER BY project_name;
--9
SELECT e.employee_id, e.first_name,e.manager_id,em.first_name AS 'manager_name'
FROM employees AS e
JOIN employees AS em
ON e.manager_id=em.employee_id
WHERE e.manager_id=3 OR e.manager_id=7
ORDER BY e.first_name;
--10
SELECT e.employee_id, CONCAT (e.first_name," ",e.last_name) AS 'employee_name', CONCAT (em.first_name," ",em.last_name) AS 'manager_name', d.name AS 'department_name'
FROM employees AS e
JOIN employees AS em
ON e.manager_id=em.employee_id
JOIN departments AS d
ON e.department_id=d.department_id
ORDER BY e.employee_id
LIMIT 5;
--11
SELECT AVG(salary) AS min_avg_salary
FROM employees
GROUP BY department_id
ORDER BY min_avg_salary
LIMIT 1;
--12
SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM mountains_countries AS mc
JOIN mountains AS m
ON mc.mountain_id=m.id
JOIN peaks AS p
ON mc.mountain_id=p.mountain_id
WHERE (mc.country_code='BG') AND (p.elevation>2835)
ORDER BY p.elevation DESC;
--13
SELECT country_code, COUNT (mountain_id) AS 'mountain_range'
FROM mountains_countries
GROUP BY country_code
HAVING country_code='BG' OR country_code='RU' OR country_code='US'
ORDER BY mountain_range DESC;
--14
SELECT c.country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers AS cr
ON cr.country_code=c.country_code
LEFT JOIN rivers AS r
ON cr.river_id=r.id
WHERE c.continent_code='AF'
ORDER BY c.country_name
LIMIT 5;
--15**
SELECT c2.continent_code,c2.currency_code, c2.currency_usage
FROM (
    SELECT c1.continent_code,c1.currency_code,c1.currency_usage,
    DENSE_RANK() OVER (PARTITION BY c1.continent_code ORDER BY c1.currency_usage DESC) AS 'ranked'
    FROM(
        SELECT continent_code,currency_code, COUNT(currency_code) AS currency_usage
        FROM countries
        GROUP BY currency_code,continent_code
        HAVING COUNT(currency_code)>1
    ) AS c1
) AS c2
WHERE ranked=1
ORDER BY c2.continent_code, c2.currency_code;
--16
SELECT COUNT(c1.country_code) AS 'country_count'
FROM
    (SELECT c.country_code, mc.mountain_id
    FROM countries AS c
    LEFT JOIN mountains_countries AS mc
    ON c.country_code=mc.country_code
    WHERE mc.mountain_id IS NULL) 
    AS c1;
--17
SELECT c.country_name, 
MAX (p.elevation) AS 'highest_peak_elevation', 
MAX(r.length) AS 'longest_river_length'
FROM countries AS c
LEFT JOIN mountains_countries AS mc
ON c.country_code=mc.country_code
LEFT JOIN peaks AS p
ON mc.mountain_id=p.mountain_id
LEFT JOIN countries_rivers AS cr
ON cr.country_code=c.country_code
LEFT JOIN rivers AS r
ON cr.river_id=r.id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC,c.country_name
LIMIT 5;
