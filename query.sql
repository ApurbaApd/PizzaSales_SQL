select * from piza_table;

--1. Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM piza_table;

--2.Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM piza_table;

--3.Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM piza_table;

--4.Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM piza_table;

--5.Average Pizzas Per Order
SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_Pizzas_per_order
FROM piza_table;

--B. Daily Trend for Total Orders
SELECT DATE_PART('dow', order_date) AS order_day,
COUNT(DISTINCT order_id) AS total_orders
FROM piza_table
GROUP BY DATE_PART('dow', order_date);

--C. Hourly Trend for Orders
SELECT DATE_PART('hour', order_time) AS order_hours,
       COUNT(DISTINCT order_id) AS total_orders
FROM piza_table
GROUP BY DATE_PART('hour', order_time)
ORDER BY DATE_PART('hour', order_time);

--In desceding order
SELECT DATE_PART('hour', order_time) AS order_hours,
 COUNT(DISTINCT order_id) AS total_orders
FROM piza_table
GROUP BY DATE_PART('hour', order_time)
ORDER BY total_orders DESC;



--% of Sales by Pizza Category--
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from piza_table) AS DECIMAL(10,2)) AS PCT
FROM piza_table
GROUP BY pizza_category;

--E.% of Sales by Pizza Size--
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from piza_table) AS DECIMAL(10,2)) AS PCT
FROM piza_table
GROUP BY pizza_size
ORDER BY pizza_size;

--witout using cast
SELECT pizza_size,
       SUM(total_price) as total_revenue,
       SUM(total_price) * 100.0 / SUM(SUM(total_price)) OVER() AS PCT
FROM piza_table
GROUP BY pizza_size
ORDER BY pizza_size;


--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category,
SUM(quantity) AS Total_Quantity_Sold
FROM piza_table
WHERE DATE_PART('month', order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


--G.Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name,
SUM(quantity) AS Total_Pizza_Sold
FROM piza_table
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;


--H.Bottom 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name,
SUM(quantity) AS Total_Pizza_Sold
FROM piza_table
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;











