/*
*  How many people were hired on any given hire date?
*  Database: Employees
*  Table: Employees
*/

SELECT COUNT(e.emp_no) AS "# of people hired", hire_date
FROM employees as e
    GROUP BY hire_date;

/*
*   Show me all the employees, hired after 1991 and count the amount of positions they've had
*  Database: Employees
*/

SELECT e.emp_no, COUNT(t.emp_no), hire_date
FROM employees as e
    INNER JOIN titles AS t ON e.emp_no = t.emp_no
        WHERE EXTRACT(year FROM hire_date) > 1991
            GROUP BY  e.emp_no
                ORDER BY e.emp_no;

SELECT * FROM titles;
/*
*  Show me all the employees that work in the department development and the from and to date.
*  Database: Employees
*/
SELECT e.emp_no, from_date, to_date
FROM employees as e
    INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
        INNER JOIN departments AS d ON de.dept_no = d.dept_no
            WHERE dept_name = 'Development';
