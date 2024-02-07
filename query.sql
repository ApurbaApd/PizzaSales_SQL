select * from piza_table;

--1. Total Revenue:
select sum(total_price) as total_revenue from piza_table;

--2.Average order value
select (sum(total_price) / count(distinct order_id)) as avg_order_value from piza_table;

--3.Total pizzas sold
select sum(quantity) as total_pizza_sold from piza_table;

--4.Total Orders
select count(distinct order_id) as total_orders from piza_table;

--5.Average pizzas per order
select sum(quantity) / count(distinct order_id) as avg_pizzas_per_order
from piza_table;

--6. Daily trend for total orders
select date_part('dow', order_date) as order_day,
count(distinct order_id) as total_orders
from piza_table
group by date_part('dow', order_date);

--7. Hourly trend for orders
select date_part('hour', order_time) as order_hours,
count(distinct order_id) as total_orders
from piza_table
group by date_part('hour', order_time)
order by date_part('hour', order_time);

--In desceding order
select date_part('hour', order_time) as order_hours,
 count(distinct order_id) as total_orders
from piza_table
group by date_part('hour', order_time)
order by total_orders desc;

--7.%of Sales by Pizza Category--
select pizza_category, cast(sum(total_price) as decimal(10,2)) as total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from piza_table) as decimal(10,2)) as pct
from piza_table
group by pizza_category;

--8.% of Sales by Pizza Size--
select pizza_size, cast(sum(total_price) as decimal(10,2)) as total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from piza_table) as decimal(10,2)) as pct
from piza_table
group by pizza_size
order by pizza_size;

--9.without using cast
select pizza_size,
sum(total_price) as total_revenue,
sum(total_price) * 100.0 / sum(sum(total_price)) over() as pct
from piza_table
group by pizza_size
order by pizza_size;

--10.Total Pizzas Sold by Pizza Category
select pizza_category,
sum(quantity) as total_quantity_sold
from piza_table
where date_part('month', order_date) = 2
group by pizza_category
order by total_quantity_sold desc;

--11.Top 5 Best Sellers by Total Pizzas Sold
select pizza_name,
sum(quantity) as total_pizza_sold
from piza_table
group by pizza_name
order by total_pizza_sold desc
limit 5;

--12.Bottom 5 Best Sellers by Total Pizzas Sold
select pizza_name,
sum(quantity) as total_pizza_sold
from piza_table
group by pizza_name
order by total_pizza_sold asc
limit 5;

--Ingredient popularity
SELECT pizza_ingredients, SUM(quantity) AS total_quantity_sold
FROM piza_table
GROUP BY pizza_ingredients
ORDER BY total_quantity_sold DESC;

--Combo analysis
SELECT pizza_size, pizza_category, SUM(quantity) AS total_quantity_sold
FROM piza_table
GROUP BY pizza_size, pizza_category
ORDER BY total_quantity_sold DESC;

--Seasonal variations
SELECT DATE_PART('month', order_date) AS order_month, COUNT(*) AS total_orders
FROM piza_table
GROUP BY DATE_PART('month', order_date)
ORDER BY total_orders DESC;


--Customer loyalty:
SELECT order_id, COUNT(*) AS order_count
FROM piza_table
GROUP BY order_id
HAVING COUNT(*) > 1;

--Upselling opportunities
SELECT pizza_name, SUM(quantity) AS total_quantity_sold
FROM piza_table
GROUP BY pizza_name
ORDER BY total_quantity_sold DESC;













