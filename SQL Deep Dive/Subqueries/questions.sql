/* TRY TO WRITE THESE AS JOINS FIRST */
/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/
SELECT orderid, customerid FROM orders WHERE customerid IN
        (SELECT customerid FROM customers WHERE state IN ('OH', 'NY', 'OR'));

SELECT * FROM orders;


/*
* DB: Employees
* Table: employees
* Question: Filter employees who have emp_no 110183 as a manager
*/
SELECT first_name, last_name FROM employees WHERE emp_no =
        (SELECT emp_no FROM dept_manager
                    WHERE emp_no = 110183);