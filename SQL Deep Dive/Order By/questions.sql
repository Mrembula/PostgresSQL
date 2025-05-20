/*
* DB: Employees
* Table: employees
* Question: Sort employees by first name ascending and last name descending
*/
SELECT first_name, last_name FROM employees
    ORDER BY first_name, last_name DESC;

/*
* DB: Employees
* Table: employees
* Question: Sort employees by age
*/
SELECT first_name, last_name, AGE(birth_date) AS "Age" FROM employees
    ORDER BY "Age";

SELECT * FROM employees
ORDER BY birth_date;

/*
* DB: Employees
* Table: employees
* Question: Sort employees who's name starts with a "k" by hire_date
*/
SELECT first_name, last_name, hire_date FROM employees
    WHERE first_name LIKE 'K%'
        ORDER BY  hire_date;
