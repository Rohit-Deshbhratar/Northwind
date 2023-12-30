USE NORTHWIND;
--1. Show the employee's first_name and last_name, a "Num_Orders" column with a count of the orders taken, 
--and a column called "Shipped" that displays "On Time" if the order shipped on time and "Late" if the order shipped late. 
--Group records by employee first_name and last_name and then by the "Shipped" status. Order by employee lastname, then by firstname, 
--and then descending by number of orders.

SELECT
	E.FIRST_NAME, E.LAST_NAME, COUNT(O.ORDER_ID) AS NUM_ORDERS,
	CASE 
		WHEN O.SHIPPED_DATE < O.REQUIRE_DATE THEN 'ON TIME' ELSE 'LATE'
	END AS SHIPPED
FROM
	ORDERS O
INNER JOIN
	EMPLOYEES E
ON
	E.EMPLOYEE_ID = O.EMPLOYEE_ID
GROUP BY
	E.FIRST_NAME, E.LAST_NAME, 
	CASE 
		WHEN O.SHIPPED_DATE < O.REQUIRE_DATE THEN 'ON TIME' ELSE 'LATE'
	END 
ORDER BY
	E.LAST_NAME, E.FIRST_NAME, NUM_ORDERS DESC;

--2. Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places.
SELECT
	YEAR(O.ORDER_DATE)AS YEAR_OF_ORDER,
	SUM(CAST(ROUND((P.UNIT_PRICE * OD.QUANTITY * OD.DISCOUNT), 2)AS DECIMAL(10, 2)))AS LOSS
	
FROM
	ORDERS O
INNER JOIN
	ORDER_DETAILS OD
ON
	O.ORDER_ID = OD.ORDER_ID
INNER JOIN
	PRODUCTS P
ON
	P.PRODUCT_ID = OD.PRODUCT_ID
WHERE 
	OD.DISCOUNT <> 0
GROUP BY
	YEAR(O.ORDER_DATE)
ORDER BY
	YEAR(O.ORDER_DATE) DESC;