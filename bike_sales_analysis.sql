-- Products Analysis
-- Q1: Find the total number of products for each product category.
	SELECT prodcategoryid, COUNT(*) as total_number
	FROM products
	GROUP BY prodcategoryid;

-- Q2: List the top 5 most expensive products.
	SELECT productid, price
	FROM products
	ORDER BY price DESC
	LIMIT 5;

-- Q3: Find all products that belong to the 'Mountain Bike' category
	SELECT p.productid, pt.short_descr
	FROM products AS p
	JOIN prodcategorytext AS pt
	ON p.prodcategoryid = pt.prodcategoryid
	WHERE pt.short_descr LIKE '%Mount%'



-- Q4: List the total sales amount (gross) for each product category
-- Q7: List the top 5 suppliers by total product sales.
-- Q6: Find the total number of products created by each employee
-- Q7: List the employees who have changed product details the most
