
/*
* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia
*/
SELECT  COUNT(*) FROM customers WHERE (age < 30 or age >= 50)
                           AND country IN ('Japan', 'Australia') AND income > 50000; --558

/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/
SELECT SUM(totalamount) AS "total_amount" FROM orders
                WHERE totalamount > 100
                    AND (orderdate >= '2004-06-01' AND orderdate <= '2004-06-30'); -- 205226.06

