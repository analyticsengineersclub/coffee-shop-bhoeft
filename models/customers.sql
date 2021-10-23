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
FROM {{ source('coffee_shop', 'customers') }} -- creates DAG dependency b/w this model & source table for docs!

)

, c_orders AS(
SELECT 
    customer_id, 
    MIN(created_at) AS first_order_at, 
    COUNT(id) AS number_of_orders
FROM {{ source('coffee_shop', 'orders') }}
GROUP BY customer_id

)

-- result interpretation: for each customer, their first order date and total number of orders
SELECT 
    customers.customer_id, 
    customers.name, 
    customers.email, 
    c_orders.first_order_at, 
    c_orders.number_of_orders
FROM customers
INNER JOIN c_orders ON customers.customer_id = c_orders.customer_id