 /*
 -- Employees Tables
 SELECT * FROM employees;

SELECT * FROM departments;

SELECT * FROM  salaries WHERE emp_no = 10001;

SELECT title FROM titles WHERE emp_no = 10006;

SELECT* FROM employees;

SELECT  emp_no, CONCAT(first_name, ' ', last_name) AS "Full Name" FROM employees;

SELECT * FROM employees
    WHERE first_name = 'Mayumi' AND last_name = 'Schueller'; --emp_no 10054
*/
SELECT * FROM customers;

SELECT firstname, lastname, gender FROM customers
    WHERE (state = 'NY'OR state = 'OR') AND gender = 'F';

SELECT * FROM employees
WHERE first_name LIKE  'G%ger';

SELECT * FROM employees
WHERE first_name ILIKE  'g%ger';

SHOW TIMEZONE;

SELECT now();

SELECT TO_CHAR(CURRENT_DATE, 'mm/dd/yyyy')

SELECT TO_CHAR(CURRENT_DATE, 'DDD');

SELECT TO_CHAR(CURRENT_DATE, 'IDDD'); -- TIME MODIFIER

SELECT TO_CHAR(CURRENT_DATE, 'WW');

-- CALCULATE THE DIFFERENCE IN TIME
SELECT now()::date - date '1800/01/01';

SELECT AGE(date '1995/12/22', date '1800/01/01');

SELECT EXTRACT (DAY FROM date '1995/12/22') AS DAY;

SELECT EXTRACT (WEEK FROM date '1995/12/22') AS WEEK;

SELECT DATE_TRUNC('year', date '1995/12/22');

SELECT * FROM orders
    WHERE purchaseDate <= now() - interval '1 year 3 months 30 days';

SELECT employees.first_name, employees.last_name FROM employees
    ORDER BY first_name DESC, last_name DESC;

SELECT CONCAT(first_name, ' ', last_name) AS "Full Name", LENGTH(employees.first_name) AS "name_len" FROM employees
    ORDER BY "name_len";


SELECT a.emp_no, CONCAT(a.first_name, a.last_name) as  "name",
    b.salary
        FROM employees as a, salaries as b
            WHERE a.emp_no  = b.emp_no  -- Can be used as SELF JOIN(primary and foreign in one table)
                 order by a.emp_no;

SELECT a.emp_no, CONCAT(a.first_name, a.last_name) as  "name",
    b.salary
        FROM employees as a
            INNER JOIN salaries as b ON b.emp_no = a.emp_no
                order by a.emp_no;

SELECT a.emp_no, CONCAT(a.first_name, a.last_name) AS "name",
c.title,
b.salary,
c.title
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
INNER JOIN titles AS c ON c.emp_no = a.emp_no
AND c.from_date = (b.from_date + interval '2days')
ORDER BY a.emp_no;
-- SAME Statements
SELECT a.emp_no, b.salary, b.from_date, c.title
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
INNER JOIN titles AS c ON c.emp_no = a.emp_no
AND (
    b.from_date = c.from_date
 OR (b.from_date + INTERVAL '2days') = c.from_date
 )
ORDER BY a.emp_no, b.from_date;

-- LEFT OUTER JOIN
SELECT emp.emp_no, dep.emp_no
FROM employees AS emp
LEFT JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
WHERE dep.emp_no IS NOT NULL;


SELECT a.emp_no, b.salary, b.from_date, COALESCE(c.title, 'no title change')
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
LEFT JOIN titles AS c ON c.emp_no = a.emp_no
AND (
    b.from_date = c.from_date
 OR (b.from_date + INTERVAL '2days') = c.from_date
 )
ORDER BY a.emp_no, b.from_date;

SELECT dept_no, count(emp_no) FROM dept_emp
    GROUP BY dept_no;

SELECT d.dept_name, COUNT(e.emp_no) AS "# of employees" FROM employees AS e
INNER JOIN dept_emp AS de ON de.dept_no = e.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no;
-- WHERE e.gender = 'F'
-- GROUP BY d.dept_name
-- HAVING  COUNT(e.emp_no) > 2500;


-- GROUP SETS
SELECT NULL AS "prod_id", sum(ol.quantity)
    FROM orderlines AS ol

UNION

SELECT prod_id AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol
GROUP BY prod_id
ORDER BY prod_id DESC;


SELECT prod_id AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol
GROUP BY GROUPING SETS  (
        (),
        (prod_id)
    )
ORDER BY prod_id DESC;

SELECT EXTRACT (YEAR FROM orderdate) AS "year",
       EXTRACT(MONTH FROM orderdate) AS "month",
       EXTRACT(DAY FROM orderdate) AS "day",
       sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
    GROUPING SETS (
    (EXTRACT (YEAR FROM orderdate)),
    (
        EXTRACT (YEAR FROM orderdate),
        EXTRACT (MONTH FROM orderdate)
    ),
    (
        EXTRACT (YEAR FROM orderdate),
        EXTRACT (MONTH FROM orderdate),
        EXTRACT (DAY FROM orderdate)
    ),
    (
        EXTRACT (MONTH FROM orderdate),
        EXTRACT (DAY FROM orderdate)
    ),
    (EXTRACT (MONTH FROM orderdate)),
    (EXTRACT (DAY FROM orderdate)),
    ()
)
ORDER BY
    EXTRACT (YEAR FROM orderdate),
    EXTRACT (MONTH FROM orderdate),
    EXTRACT (DAY FROM orderdate);


-- WINDOW FUNCTION
SELECT *, MAX(salary) OVER() FROM salaries;

SELECT *, MAX(salary) OVER() FROM salaries
    WHERE salary < 70000;

-- PARTITION
SELECT *, dept_name, AVG(salary) OVER(
        PARTITION BY d.dept_name
    ) FROM salaries
    JOIN dept_emp AS de USING (emp_no)
        JOIN departments AS d USING (dept_no);

-- ORDER BY USING WINDOW FUNCTION
SELECT emp_no, count(salary) OVER(
        ORDER BY emp_no -- USING PARTITION BY GIVE ALMOST THE SAME DATA
    ) FROM salaries;

SELECT emp_no, salary, COUNT(salary) OVER(
        PARTITION BY emp_no
        ORDER BY salary
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) FROM salaries;

SELECT DISTINCT e.emp_no,
                e.first_name,
                d.dept_name,
                LAST_VALUE(s.salary) OVER (
                    PARTITION BY e.emp_no
                    ORDER BY s.from_date
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS "Current Salary"

FROM salaries AS s
JOIN employees AS e ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no

ORDER BY  e.emp_no;

SELECT DISTINCT emp_no,
                LAST_VALUE(salary) OVER (
                    PARTITION BY s.emp_no
                    ORDER BY s.from_date
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    )
FROM salaries AS s;

-- FIRST VALUE
SELECT prod_id,
       price,
       category,
       FIRST_VALUE(price) OVER (
           PARTITION BY category ORDER BY price RANGE BETWEEN UNBOUNDED PRECEDING
           AND UNBOUNDED  FOLLOWING
           ) AS "cheapest in category"
FROM products;

-- LAST VALUE
SELECT prod_id,
       price,
       category,
       LAST_VALUE(price) OVER (
           PARTITION BY category ORDER BY price RANGE BETWEEN UNBOUNDED PRECEDING
           AND UNBOUNDED  FOLLOWING
           ) AS "most expensive category"
FROM products;

-- OR

SELECT prod_id,
       price,
       category,
       MAX(price) OVER (
           PARTITION BY category
           ) AS "most expensive category"
FROM products;

-- SUM
SELECT o.orderid,
    o.customerid,
    o.netamount,
    SUM(o.netamount) OVER (
        PARTITION BY o.customerid
        ORDER BY o.orderid
        ) AS "cum sum"
FROM orders AS o
ORDER BY o.customerid;

-- ROW_NUMBER
SELECT
    prod_id,
    price,
    category,
    ROW_NUMBER() OVER(
        PARTITION BY  category ORDER BY price
        ) AS "posititon in category by pricemy"
    FROM products;

-- Conditionals Statement
SELECT o.orderid,
        o.customerid,
        CASE
            WHEN o.customerid = 1
            THEN 'my first customer'
            ELSE 'not my first customer'
        END,
        O.netamount
FROM orders as o
ORDER BY  o.customerid;

-- USING WHERE CLAUSE
SELECT
FROM orders as o
WHERE CASE WHEN o.customerid > 10 THEN o.netamount < 100
ELSE o.netamount > 100 END
ORDER BY o.customerid;

SELECT
    SUM(
        CASE
            WHEN o.netamount < 100
            THEN -100
            ELSE o.netamount
        END
    ) AS "returns",
    SUM(o.netamount) AS "normal total"
FROM orders AS o;

-- Nullif
-- NULLIF(val1, val2) val1 AND val2 equal return NULL

-- VIEW FUNCTION
CREATE OR REPLACE VIEW last_salary_change AS
    SELECT e.emp_no,
           max(s.from_date)

    FROM salaries AS s

    JOIN employees as e ON s.emp_no = e.emp_no
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    JOIN departments AS d ON de.dept_no = d.dept_no

    GROUP BY E.emp_no
    ORDER BY emp_no;

SELECT * FROM last_salary_change;

SELECT * FROM salaries
JOIN last_salary_change USING (emp_no)
WHERE from_date = last_salary_change.max
ORDER BY emp_no;

-- INDEXES
EXPLAIN ANALYZE
SELECT "name", district, countrycode FROM city
WHERE countrycode IN ('TUN', 'BE', 'NL');

CREATE INDEX idx_countrycode
ON city (countrycode);

--PARTIAL INDEX
CREATE INDEX index_country
ON city (countrycode) WHERE countrycode IN ('TUN', 'BE', 'NL');

-- USING ALGORITHMS
CREATE INDEX index_country
ON city  USING hash(countrycode)

--SUB QUERIES
SELECT title, price, (SELECT AVG(price) FROM products) AS "global average price"
FROM ( SELECT * FROM products WHERE price > 20)
AS "products_sub";

-- SINGLE ROW
SELECT  salary
FROM salaries WHERE salary =
                     (SELECT AVG(salary) FROM salaries);

SELECT salary, (SELECT AVG(salary) FROM salaries)
    FROM salaries


-- MULTIPLE ROW


--MULTIPLE COLUMN
SELECT AVG(dea) AS "Department average salary"
FROM salaries
JOIN dept_emp AS de USING (emp_no)
JOIN  (
    SELECT dept_no FROM salaries AS s2
        JOIN  dept_emp AS e USING (emp_no)
            GROUP BY dept_no
) AS dea USING (dept_no)
WHERE salary > AVG(dea); -- NW

SELECT first_name, last_name, birth_date,
    AGE(birth_date), (SELECT AVG(age(birth_date)) FROM employees)
    FROM employees
WHERE AGE(birth_date) > (SELECT AVG(age(birth_date)) FROM employees);

-- CORRELATED SUB QUERY
SELECT emp_no, salary, from_date,
    ( SELECT title FROM titles AS
        t WHERE t.emp_no = s.emp_no
          AND t.from_date = s.from_date)
FROM salaries AS s
ORDER BY emp_no;


SELECT emp_no, salary AS "most recent salary",
    from_date
FROM salaries AS s
JOIN (
    SELECT emp_no, MAX(from_date) AS "max"
    FROM salaries AS sp
    GROUP BY emp_no
    ) AS ls USING (emp_no)
WHERE ls.max = from_date
ORDER BY emp_no;

SELECT firstname, lastname, income
FROM customers AS c
WHERE EXISTS ( -- EXISTS
    SELECT * FROM orders AS o
    WHERE c.customerid = o.customerid AND totalamount > 400
) AND income > 90000;

-- ANY (DO A SEARCH)

SELECT products.prod_id, products.title, sales
       FROM products
    JOIN inventory AS i USING (prod_id)
WHERE i.sales > ALL ( -- ALL
    SELECT AVG(sales) FROM inventory
    JOIN products AS p1 USING (prod_id)
    GROUP BY p1.category
    );

DROP TABLE student;

-- CREATE A TABLE ZTM
CREATE TABLE student(
    student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email  TEXT,
    date_of_birth DATE NOT NULL
    -- CONSTRAINT pk_student_id PRIMARY KEY (student_id)  TABLE CONSTRAINT
);

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE DOMAIN Rating SMALLINT
    CHECK ( VALUE > 0 AND VALUE <= 5 ); -- FOR RATING

CREATE TYPE Feedback AS (
    student_id UUID,
    rating Rating,
    feedback TEXT
);

CREATE TABLE  subject (
    subject_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subject TEXT NOT NULL,
    description TEXT
);

CREATE TABLE teacher (
    teacher_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email TEXT,
    date_of_birth DATE NOT NULL
);

CREATE TABLE course (
    course_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "name" TEXT NOT NULL,
    description TEXT,
    subject_id UUID REFERENCES subject(subject_id),
    teacher_id UUID REFERENCES teacher(teacher_id),
    feedback feedback[]
);

CREATE TABLE enrollment (
    course_id UUID REFERENCES course(course_id),
    student_id UUID REFERENCES student(student_id),
    enrollment_date DATE NOT NULL,
    CONSTRAINT pk_enrollment PRIMARY KEY (course_id, student_id)
);

INSERT INTO student (first_name, last_name, email, date_of_birth)
VALUES ('Mo', 'Bini','mo@bini.io', '1992-11-13'::DATE);

INSERT INTO teacher(first_name, last_name, email, date_of_birth)
VALUES ('Tebogo', 'Sekhula', 'tebogo@sekhula.io', '1985-12-22'::DATE);

SELECT * FROM student;

INSERT INTO subject(subject, description)
VALUES ('SQL', 'A database management language');

SELECT * FROM subject;


INSERT INTO course(name, description, subject_id, teacher_id)
VALUES ('SQL Zero to Mastery', 'The art of SQL Mastery',
        '11736b91-ff7a-4410-a57c-a3b3829942a9', '9e1c9166-b19a-4c1a-b4d5-5035132d6c95');

SELECT * FROM course;

ALTER TABLE course ALTER COLUMN teacher_id SET NOT NULL;

INSERT INTO enrollment(student_id, course_id, enrollment_date)
VALUES ('dece2a1e-829c-48f9-a7f0-7ad98ae6f809', 'e44abc68-e85c-4ef0-b652-3564862c1775', NOW()::DATE);

SELECT * FROM enrollment;

UPDATE course
SET feedback = array_append(
            feedback,
               ROW(
                    'dece2a1e-829c-48f9-a7f0-7ad98ae6f809',
                   5,
                   'Great Course'
                   )::feedback
               )
WHERE course_id = 'e44abc68-e85c-4ef0-b652-3564862c1775';