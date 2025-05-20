/*
*  Calculate the total amount of employees per department and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/
SELECT dept_no, sum(emp_no) AS "# of employees" FROM dept_emp
    GROUP BY GROUPING SETS (
        (),
        (dept_no)
    )
ORDER BY dept_no;
-- You are using the sum(emp_no) to group sets the items

/*  Calculate the total average salary per department and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/
SELECT * FROM salaries;
SELECT dept_no, AVG(salary)  FROM salaries
    INNER JOIN employees ON salaries.emp_no = employees.emp_no
        INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
            GROUP BY GROUPING SETS (
                (dept_no),
                ()
            )
ORDER BY dept_no;