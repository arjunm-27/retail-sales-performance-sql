/* 5 most profitable products */

SELECT 
p.product_name,
p.category,
ROUND(SUM((p.selling_price - p.cost_price) * oi.quantity), 2) AS total_profit
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_profit DESC
LIMIT 5 ;

/* Products that sold more than 75 units in 2025. These have the most demand */

SELECT 
p.product_name,
SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity) > 75
ORDER BY total_units_sold DESC;

/* Total quantity of products purchased by each gender */

SELECT c.gender, SUM(oi.quantity) as sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.gender 
ORDER BY sales DESC;

/* Quantity of products sold in each city */

SELECT c.city , SUM(oi.quantity) as sales 
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city 
ORDER BY sales DESC;

/* Top 10 products with the highest quantity sold in 2025 and which gender purchased them the most */

SELECT 
p.product_name,
c.gender,
SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY p.product_name, c.gender
ORDER BY total_units_sold DESC
LIMIT 10;

/* Products with High Markup But Low Sales. These are overpriced products with low demand */

SELECT 
p.product_name,
(p.selling_price - p.cost_price) AS markup,
SUM(oi.quantity) AS units_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name, markup
HAVING SUM(oi.quantity) < 25
ORDER BY markup DESC;

/* Highest revenue-making categories */

SELECT 
p.category,
SUM((p.selling_price - p.cost_price) * oi.quantity) AS profit
FROM 
order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY 
p.category
ORDER BY 
profit DESC;

/* Most profitable category */

SELECT 
p.category,
SUM((p.selling_price - p.cost_price) * oi.quantity) AS profit
FROM 
order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY 
p.category
ORDER BY 
profit DESC;

/* 5 customers with the highest lifetime spending value. */ 

SELECT 
c.customer_id,
c.customer_name,
SUM(p.selling_price * oi.quantity) AS customer_lifetime_value
FROM 
customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY customer_lifetime_value DESC
LIMIT 5;

/* Monthly revenue and quantities of products sold */

SELECT 
DATE_TRUNC('month', order_date) AS month,
COUNT(*) AS orders, 
SUM(p.selling_price * oi.quantity) AS revenue
FROM 
orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY month
ORDER BY orders DESC;





