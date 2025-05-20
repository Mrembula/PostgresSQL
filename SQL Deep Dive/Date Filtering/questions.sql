/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/
SELECT *, AGE(birth_date) FROM employees
    WHERE  EXTRACT(YEAR FROM birth_date) >= 60; -- 300 024



/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/
SELECT * FROM employees
    WHERE EXTRACT(MONTH FROM hire_date) = 02; -- 24 448

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/
SELECT * FROM employees
    WHERE EXTRACT(month FROM birth_date) = 11; -- 24 500
/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/

SELECT MAX(AGE("birth_date")) FROM employees;-- 72 years

/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/

SELECT COUNT(*) FROM orders
    WHERE EXTRACT(year FROM orderdate) = 2004; -- 12 000

