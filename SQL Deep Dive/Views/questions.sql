/*
*  Create a view "90-95" that:
*  Shows me all the employees, hired between 1990 and 1995
*  Database: Employees
*/

CREATE VIEW "90-95" AS
    SELECT * FROM employees
        WHERE EXTRACT(YEAR FROM hire_date) BETWEEN 1990 AND 1995;

SELECT * FROM "90-95";

/*
*  Create a view "bigbucks" that:
*  Shows me all employees that have ever had a salary over 80000
*  Database: Employees
*/

CREATE VIEW "bigbucks" AS
    SELECT emp_no, salary  FROM salaries
        WHERE salary > 80000
            GROUP BY emp_no, salary;

