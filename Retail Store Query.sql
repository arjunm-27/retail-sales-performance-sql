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

/* Products that sold more than 75 units in 2025 */

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

/* Quantity of products sold in each state */

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







