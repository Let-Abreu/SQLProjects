/*Brazillian ecommerce Data Exploration

Skills used: Join, Aggregate functions, Datetime functions, Format date

*/

-- Finding the number of orders made per day of week, by year and state

SELECT
  COUNT(order_id) AS num_orders,
  FORMAT_DATETIME("%A", DATETIME (order_purchase_timestamp)) AS day_of_week,
  customer_state AS state,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year
FROM
  `olist_orders_dataset` AS orders
JOIN
  `olist_customers_dataset` AS customers
ON
  orders.customer_id = customers.customer_id
GROUP BY
  day_of_week,
  year,
  state

-- Finding the number of orders made per month, by year and state

SELECT 
  COUNT(order_id) AS num_orders,
  FORMAT_DATETIME("%B", DATETIME (order_purchase_timestamp)) AS month,
  customer_state AS state,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year
FROM 
  `olist_orders_dataset` AS orders
JOIN
  `olist_customers_dataset` AS customers
ON
  orders.customer_id = customers.customer_id
GROUP BY
  month,
  state,
  year

-- Finding the favorite type of payment, by year and state

SELECT
  COUNT(orders.order_id) AS num_orders,
  payment.payment_type AS payment_type,
  customer_state AS state,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year
FROM
  `olist_order_payments_dataset` AS payment
JOIN 
  `olist_orders_dataset` AS orders
ON
  payment.order_id = orders.order_id  
JOIN
  `olist_customers_dataset` AS customers
ON
  orders.customer_id = customers.customer_id    
GROUP BY
  payment_type,
  year,
  state

-- Finding the average money spent per order, by year and state

SELECT
  AVG(payment_value) AS avg_money_spent,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  customer_state AS state
FROM
  `olist_order_payments_dataset` AS payments
JOIN
  `olist_orders_dataset` AS orders
ON
  payments.order_id = orders.order_id
JOIN
  `olist_customers_dataset` AS customers
ON
  orders.customer_id = customers.customer_id 
GROUP BY
  year,
  state

-- Finding the total number of orders made, by year and state

SELECT
  COUNT(order_id) AS num_of_orders,
  customers.customer_state AS state,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year
FROM
  `olist_orders_dataset` AS orders
JOIN
  `olist_customers_dataset` AS customers
ON
  orders.customer_id = customers.customer_id
GROUP BY
  year,
  state

-- Finding the total money spent in orders, by year and state

SELECT
  SUM(payment_value) AS total_money_spent,
  customer_state AS state,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year
FROM
  `olist_order_payments_dataset` AS payment
JOIN
  `olist_orders_dataset` AS orders
ON
  payment.order_id = orders.order_id
JOIN
  `olist_customers_dataset` AS customers
ON
  orders.customer_id = customers.customer_id  
GROUP BY
  year,
  state

