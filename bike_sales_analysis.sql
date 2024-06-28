-- Products Analysis

-- Q1: Find the total number of products for each product category.
	SELECT 
		prodcategoryid, 
		COUNT(*) as total_number
	FROM 
		products
	GROUP BY 
		prodcategoryid;

-- Q2: List the top 5 most expensive products.
	SELECT 
		productid, 
		price
	FROM 
		products
	ORDER BY 
		price DESC
	LIMIT 5;

-- Q3: Find all products that belong to the 'Mountain Bike' category
	SELECT 
		p.productid, 
		pt.short_descr
	FROM 
		products AS p
	JOIN 
		prodcategorytext AS pt ON p.prodcategoryid = pt.prodcategoryid
	WHERE 
		pt.short_descr LIKE '%Mount%';


-- Q4: List the total sales amount (gross) for each product category
	SELECT p.prodcategoryid,
		pt.short_descr,
		SUM(si.grossamount) AS total_gross_sales
	FROM 
		salesitem AS si
	JOIN 
		products AS p ON si.productid = p.productid
	JOIN 
		prodcategorytext AS pt	ON p.prodcategoryid = pt.prodcategoryid
	GROUP BY 
		p.prodcategoryid, 
		pt.short_descr;


-- Q5: List the top 5 suppliers by total product sales.	
	WITH topsupplier AS(
		SELECT o.partnerid, 
			COUNT(si.salesorderitem) AS total_product_sales,
			DENSE_RANK() OVER(ORDER BY COUNT(si.salesorderitem)DESC) AS top_suppliers
		FROM 
			salesitem AS si
		JOIN 
			orders AS o ON si.salesorderid = o.salesorderid
		GROUP BY 
			o.partnerid
		ORDER BY 
			total_product_sales DESC
	)
	SELECT *
	FROM 
		topsupplier
	WHERE 
		top_suppliers <= 5;

		
-- Q6: Find the total number of products created by each employee.
	SELECT
		e.first_name || ' ' || e.last_name AS employee_name,
		COUNT(productid) AS number_of_products_created
	FROM 
		products AS p
	JOIN 
		employees AS e ON p.createdby = e.employee_id
	GROUP BY 
		e.first_name, e.last_name;

	
-- Q7: List the employees who have changed product details the most
	SELECT
		e.first_name || ' ' || e.last_name AS employee_name,
		COUNT(productid) AS number_of_products_details_changed
	FROM 
		products AS p
	JOIN 
		employees AS e ON p.changedby = e.employee_id
	GROUP BY 
		e.first_name, e.last_name;

--**********************************************************************************************
	
-- Sales Orders Items Analysis

-- Q8: Calculate the total gross amount for each sales order.
	SELECT SUM(grossamount) AS total_gross_amount
	FROM orders;


-- Q9: Which products contribute the most to revenue when the billing status is 'Complete'
	SELECT 
	    salesorderid, 
	    netamount, 	    
	   	ROUND((netamount / SUM(netamount) OVER() * 100),2) AS revenue_contribution,		
	    SUM(netamount) OVER() AS total_revenue,
		billingstatus
	FROM 
   	 orders;


-- Q10: Find the sales order items for a specific product ID.

	SELECT 
		productid, 
		salesorderid
	FROM 
		salesitem
	GROUP BY 
		productid, salesorderid;
		
--**************************************************************************************************
