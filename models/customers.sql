-- models/customers.sql config block
{{
    config(
        materialized='table'
    )
}}


WITH customers AS(

SELECT 
    id as customer_id, 
    name, 
    email
FROM `analytics-engineers-club.coffee_shop.customers`

)

, c_orders AS(
-- order metrics by customer id
SELECT 
    customer_id, 
    MIN(created_at) AS first_order_at, 
    COUNT(id) AS number_of_orders
FROM `analytics-engineers-club.coffee_shop.orders`
GROUP BY customer_id

)

SELECT 
    customers.customer_id, 
    customers.name, 
    customers.email, 
    c_orders.first_order_at, 
    c_orders.number_of_orders
FROM customers
INNER JOIN c_orders ON customers.customer_id = c_orders.customer_id