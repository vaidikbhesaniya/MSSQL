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

