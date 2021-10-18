SELECT 
    -- signup_week def: begins on a Monday datetime
    date_trunc(first_order_at, WEEK(MONDAY)) AS signup_week,
    COUNT(customer_id) AS new_customers
FROM {{ ref('customers') }}
GROUP BY signup_week
ORDER BY signup_week