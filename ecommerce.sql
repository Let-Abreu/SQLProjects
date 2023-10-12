/*Brazillian ecommerce Data Exploration

Skills used: Join, Aggregate functions, Datetime functions, Format date

*/

-- Finding the places where most customers are from
-- Cep is the brazilian zip code
SELECT
  COUNT(customer_unique_id) AS num_customers,
  geolocation.geolocation_zip_code_prefix AS cep,
  geolocation_lat AS lat,
  geolocation_lng AS long
FROM
  `olist_customers_dataset` AS customers
JOIN
  `olist_geolocation_dataset` AS geolocation
ON
  customers.customer_zip_code_prefix = geolocation.geolocation_zip_code_prefix    
GROUP BY
  cep,
  lat,
  long
ORDER BY
  num_customers DESC



-- Finding the date with the most orders
SELECT
  COUNT(order_id) AS num_orders,
  EXTRACT(DATE FROM order_purchase_timestamp) AS day
FROM
  `olist_orders_dataset`
GROUP BY
  day
ORDER BY
  num_orders DESC
LIMIT 1


-- Finding the number of orders made in each day of the week 
SELECT
  COUNT(order_id) AS num_orders,
  FORMAT_DATETIME("%A", DATETIME (order_purchase_timestamp)) AS day_of_week
FROM
  `olist_orders_dataset`
GROUP BY
  day_of_week
ORDER BY
  num_orders DESC


-- Finding the number of orders made per month, by year
SELECT 
  COUNT(order_id) AS num_orders,
  FORMAT_DATETIME("%B", DATETIME (order_purchase_timestamp)) AS month,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year
FROM 
  `olist_orders_dataset`
GROUP BY
  month,
  year 
ORDER BY 
  year,
  month ASC



-- Finding the top five products categories with the most orders
SELECT
  COUNT(orders.order_id) AS num_of_orders,
  product_category_name
FROM
  `olist_orders_dataset` AS orders
JOIN
  `olist_order_items_dataset` AS items 
ON
  orders.order_id = items.order_id
JOIN
  `olist_products_dataset` AS products
ON
  items.product_id = products.product_id
GROUP BY
  product_category_name
ORDER BY
  num_of_orders DESC LIMIT 5




