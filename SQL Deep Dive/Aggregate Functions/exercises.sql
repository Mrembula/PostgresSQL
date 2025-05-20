-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: Employees
 */
-- 


-- Question 1: What is the average salary for the company?
-- Table: Salaries
SELECT AVG(salaries.salary) AS "Average Salary" FROM salaries; -- 63810.74


-- Question 2: What year was the youngest person born in the company?
-- Table: employees
select * from employees;
SELECT MAX(employees.birth_date) AS "youngest Employee" FROM employees; -- 1965-02-01


-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: France
 */
--

-- Question 1: How many towns are there in france?
-- Table: Towns
SELECT COUNT(code) AS "Number of Towns" FROM towns; -- 36684

-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: World
 */
--

-- Question 1: How many official languages are there?
-- Table: countrylanguage

SELECT COUNT(DISTINCT(countrylanguage.language)) AS "Distinict Languages" FROM countrylanguage; -- 457
SELECT COUNT(countrylanguage.language) FROM countrylanguage; -- 984

-- Question 2: What is the average life expectancy in the world?
-- Table: country
    SELECT * FROM country;
SELECT AVG(country.lifeexpectancy) AS "Global Life Expectency" FROM country; -- 66.48

-- Question 3: What is the average population for cities in the netherlands?
-- Table: city
SELECT AVG(population) AS "Average NLD population" FROM city WHERE countrycode = 'NLD'; -- 185001.75

