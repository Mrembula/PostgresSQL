
/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/
SELECT orderid, state FROM customers
    INNER JOIN orders ON customers.customerid = orders.customerid
        WHERE state IN ('OH', 'NY', 'OR')
            ORDER BY orderid;

/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/
SELECT title, actor, price, quan_in_stock FROM products
    INNER JOIN inventory ON products.prod_id = inventory.prod_id;

/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/
SELECT CONCAT(first_name, ' ', last_name) AS "Full Name", dept_emp.emp_no, dept_name  FROM employees
    INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
        INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
            ORDER BY emp_no
