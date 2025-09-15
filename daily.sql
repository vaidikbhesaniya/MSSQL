--Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

--Return the result table in any order.
use weatherdata
select * from weather

SELECT *
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(DAY, w2.recordDate, w1.recordDate) = 1


SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(DAY,w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;



--  Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

--The scores should be ranked from the highest to the lowest.
--If there is a tie between two scores, both should have the same ranking.
--After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
--Return the result table ordered by score in descending order.--/

CREATE TABLE Scores (
    id INT identity(1,1) PRIMARY KEY,
    score DECIMAL(4,2) NOT NULL
);

INSERT INTO Scores (score) VALUES
(3.50),
(3.65),
(4.00),
(3.85),
(4.00),
(3.65);

select * from scores
-- MySQL 8.0+
SELECT score,
       DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM Scores



--Find all numbers that appear at least three times consecutively.

--Return the result table in any order.

--The result format is in the following example.


-- Create the Logs table
CREATE TABLE Logs (
    id INT PRIMARY KEY,
    num VARCHAR(10)  -- varchar so it matches your schema
);

-- Insert values into Logs
INSERT INTO Logs (id, num) VALUES
(1, '1'),
(2, '1'),
(3, '1'),
(4, '2'),
(5, '1'),
(6, '2'),
(7, '2');

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1 AND l1.num = l2.num
JOIN Logs l3 ON l2.id = l3.id - 1 AND l2.num = l3.num;






--06 09 2024


--Write a solution to find employees who have the highest salary in each of the departments.

--Return the result table in any order.

--The result format is in the following example.

 




-- Create Department table
CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Insert values into Department table
INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Create Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

-- Insert values into Employee table
INSERT INTO Employee (id, name, salary, departmentId) VALUES
(1, 'Joe', 70000, 1),
(2, 'Jim', 90000, 1),
(3, 'Henry', 80000, 2),
(4, 'Sam', 60000, 2),
(5, 'Max', 90000, 1);


select * from employee

select * from department

SELECT d.name AS Department,
       e.name AS Employee,
       e.salary AS Salary
FROM Employee e
JOIN Department d
    ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE departmentId = e.departmentId
);



--Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

-- Create Person table
CREATE TABLE Person (
    id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL
);
drop table person

-- Insert sample data
INSERT INTO Person (id, email) VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

-- Check inserted data
SELECT * FROM Person;

DELETE FROM Person
WHERE id NOT IN (
    SELECT id FROM (
        SELECT MIN(id) AS id
        FROM Person
        GROUP BY email
    ) AS temp
);





--07 09 2004
create database sevennine
use sevennine
CREATE TABLE Users (
    users_id INT PRIMARY KEY,
    banned VARCHAR(10),   -- instead of ENUM
    role VARCHAR(10)      -- instead of ENUM
);

CREATE TABLE Trips (
    id INT PRIMARY KEY,
    client_id INT,
    driver_id INT,
    city_id INT,
    status VARCHAR(30),   -- instead of ENUM
    request_at DATE,
    FOREIGN KEY (client_id) REFERENCES Users(users_id),
    FOREIGN KEY (driver_id) REFERENCES Users(users_id)
);

INSERT INTO Users (users_id, banned, role) VALUES
(1, 'No', 'client'),
(2, 'Yes', 'client'),
(3, 'No', 'client'),
(4, 'No', 'client'),
(10, 'No', 'driver'),
(11, 'No', 'driver'),
(12, 'No', 'driver'),
(13, 'No', 'driver');

INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES
(1, 1, 10, 1, 'completed', '2013-10-01'),
(2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
(3, 3, 12, 6, 'completed', '2013-10-01'),
(4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
(5, 1, 10, 1, 'completed', '2013-10-02'),
(6, 2, 11, 6, 'completed', '2013-10-02'),
(7, 3, 12, 6, 'completed', '2013-10-02'),
(8, 2, 12, 12, 'completed', '2013-10-03'),
(9, 3, 10, 12, 'completed', '2013-10-03'),
(10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');

select * from trips
select * from users

SELECT 
    t.request_at AS Day,
    ROUND(
        CAST(SUM(CASE WHEN t.status IN ('cancelled_by_driver','cancelled_by_client') THEN 1 ELSE 0 END) AS FLOAT)
        / COUNT(*), 
        2
    ) AS Cancellation_Rate
FROM Trips t
JOIN Users c ON t.client_id = c.users_id AND c.banned = 'No'
JOIN Users d ON t.driver_id = d.users_id AND d.banned = 'No'
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;

SELECT 
    request_at AS Day,
    ROUND(
        CAST(SUM(CASE WHEN status IN ('cancelled_by_driver','cancelled_by_client') THEN 1 ELSE 0 END) AS FLOAT)
        / COUNT(*), 
        2
    ) AS Cancellation_Rate
FROM Trips
GROUP BY request_at;


--08-09-25
CREATE DATABASE eightnine
USE eightnine

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);


INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

select * from activity

select player_id , min(event_date) as first_login
from activity 

group by player_id



----


CREATE TABLE Customer (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    referee_id INT
);


INSERT INTO Customer (id, name, referee_id) VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2);

SELECT * FROM Customer;


SELECT name
FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL;



--09-09-2004

create database ninenine

use ninenine


CREATE TABLE Orders (
    order_number INT PRIMARY KEY,
    customer_number INT
);

INSERT INTO Orders (order_number, customer_number) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 3);


SELECT Top 1 customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC;


-11/09/25

create database elevennine;
use elevennine

CREATE TABLE Courses (
    student VARCHAR(50),
    class VARCHAR(50),
    PRIMARY KEY (student, class)
);

INSERT INTO Courses (student, class) VALUES
('A', 'Math'),
('B', 'English'),
('C', 'Math'),
('D', 'Biology'),
('E', 'Math'),
('F', 'Computer'),
('G', 'Math'),
('H', 'Math'),
('I', 'Math');

--select class from (
--select top 1 class ,count(class) as total from Courses
--group by class
--order by  total desc
--) as t

 select
    class
from
    Courses 
group by
    class
having
    count(student)>=5



--12-09-25

create database twelwenine;
use twelwenine

CREATE TABLE SalesPerson (                 
    sales_id INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    commission_rate INT NOT NULL,
    hire_date DATE NOT NULL
);


INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date)
VALUES 
(1, 'John', 100000, 6, '2006-04-01'),
(2, 'Amy', 12000, 5, '2010-05-01'),
(3, 'Mark', 65000, 12, '2008-12-25'),
(4, 'Pam', 25000, 25, '2005-01-01'),
(5, 'Alex', 5000, 10, '2007-02-03');

CREATE TABLE Company (
    com_id INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    city NVARCHAR(50) NOT NULL
);

INSERT INTO Company (com_id, name, city)
VALUES
(1, 'RED', 'Boston'),
(2, 'ORANGE', 'New York'),
(3, 'YELLOW', 'Boston'),
(4, 'GREEN', 'Austin');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    com_id INT NOT NULL,
    sales_id INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (com_id) REFERENCES Company(com_id),
    FOREIGN KEY (sales_id) REFERENCES SalesPerson(sales_id)
);

INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount)
VALUES
(1, '2014-01-01', 3, 4, 10000),
(2, '2014-02-01', 4, 5, 5000),
(3, '2014-03-01', 1, 1, 50000),
(4, '2014-04-01', 1, 4, 25000);

select * from SalesPerson

select * from Company

select * from Orders

select  * from SalesPerson s
join orders o on s.sales_id=o.sales_id 
join Company c on c.com_id=o.com_id


SELECT DISTINCT o.sales_id
FROM Orders o
JOIN Company c ON o.com_id = c.com_id
WHERE c.name = 'RED'


SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    SELECT DISTINCT o.sales_id
    FROM Orders o
    JOIN Company c
        ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);


-12-09-25


--Report for every three line segments whether they can form a triangle.

--Return the result table in any order.

--The result format is in the following example.

create database twelvenine
use twelvenine

CREATE TABLE Triangle (
    x INT,
    y INT,
    z INT,
    PRIMARY KEY (x, y, z)
);


INSERT INTO Triangle (x, y, z) VALUES
(13, 15, 30),
(10, 20, 15);


SELECT
    x,
    y,
    z,
    CASE
        WHEN x + y > z AND x + z > y AND y + z > x
        THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle;




--13/09/25

create database thirteennine
use thirteennine

CREATE TABLE MyNumbers (
    num INT
);


INSERT INTO MyNumbers (num)
VALUES
(8),
(8),
(3),
(3),
(1),
(4),
(5),
(6);

select  * from mynumbers

select top 1 num from MyNumbers group by num having count(num)=1 order by num desc 

SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS singles;


--14/09/25

create database forteennine
use forteennine



CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    experience_years INT NOT NULL
);


CREATE TABLE Project (
    project_id INT NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);


INSERT INTO Employee (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 1),
(4, 'Doe', 2);


INSERT INTO Project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);

select * from Employee
select * from Project


select  * from employee e join project p on e.employee_id=p.employee_id
SELECT 
    p.project_id,
    AVG(e.employee_id) AS employee_count
FROM Project p
JOIN Employee e 
    ON e.employee_id = p.employee_id
GROUP BY p.project_id;
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years * 1.0), 2) AS average_years
FROM Project p
JOIN Employee e 
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;


--15/09/25

create database nine
CREATE TABLE Activity (
    user_id INT NOT NULL,
    session_id INT NOT NULL,
    activity_date DATE NOT NULL,
    activity_type VARCHAR(20) NOT NULL
);

INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES
(1, 1, '2019-07-20', 'open_session'),
(1, 1, '2019-07-20', 'scroll_down'),
(1, 1, '2019-07-20', 'end_session'),
(2, 4, '2019-07-20', 'open_session'),
(2, 4, '2019-07-21', 'send_message'),
(2, 4, '2019-07-21', 'end_session'),
(3, 2, '2019-07-21', 'open_session'),
(3, 2, '2019-07-21', 'send_message'),
(3, 2, '2019-07-21', 'end_session'),
(4, 3, '2019-06-25', 'open_session'),
(4, 3, '2019-06-25', 'end_session');

select *  from Activity

SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date;
