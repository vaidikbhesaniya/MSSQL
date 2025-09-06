--Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

--Return the result table in any order.

select * from weather

SELECT *
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(DAY, w2.recordDate, w1.recordDate) = 1



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
