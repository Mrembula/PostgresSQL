-- How many female customers do we have from the state of Oregon (OR)?
/*
* Write your query here
*/
SELECT COUNT(*) FROM customers
    WHERE gender = 'F' AND state = 'OR'; -- 106

-- Who over the age of 44 has an income of 100 000 or more? (excluding 44)
/*
* Write your query here
*/
SELECT COUNT(*) FROM customers
        WHERE income >= 100000 AND age > 44; -- 2497

-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)

/*
* Write your query here
*/
SELECT COUNT(*) FROM customers
         WHERE (age >= 30 AND age <= 50) AND income <= 50000; -- 2362

-- What is the average income between the ages of 20 and 50? (Excluding 20 and 50)
/*
* Write your query here
*/
SELECT ROUND(AVG(income), 2) AS Average FROM customers
        WHERE age > 20 AND  age < 50; -- 59409.93