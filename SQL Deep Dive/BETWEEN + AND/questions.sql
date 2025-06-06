-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)
/*
* Write your query here
*/
SELECT count(*) FROM customers
         WHERE age BETWEEN 30 AND 50 AND income < 50000; -- 2362


-- What is the average income between the ages of 20 and 50? (Including 20 and 50)
/*
* Write your query here
*/
SELECT avg(income) FROM customers
                WHERE age BETWEEN 20 AND 50; -- 59361.96