-- models/customers.sql config block
{{
    config(
        materialized='table'
    )
}}


WITH customers AS(

SELECT 
    customer_id, 
    customer_name, 
    customer_email
FROM {{ ref('stg_coffee_shop__customers') }}

)

, c_orders AS(
SELECT 
    customer_id, 
    MIN(ordered_at) AS first_order_at, 
    COUNT(order_id) AS number_of_orders
FROM {{ ref('stg_coffee_shop__orders') }}
GROUP BY customer_id

)

-- result interpretation: for each customer, their first order date and total number of orders
SELECT 
    customers.customer_id, 
    customers.customer_name, 
    customers.customer_email, 
    c_orders.first_order_at, 
    c_orders.number_of_orders
FROM customers
INNER JOIN c_orders ON customers.customer_id = c_orders.customer_id