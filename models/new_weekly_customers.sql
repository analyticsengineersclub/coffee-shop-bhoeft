SELECT 
    -- week defined: begins Monday, ends day before next begin date
    date_trunc(first_order_at, WEEK(MONDAY)) AS signup_week,
    COUNT(customer_id) AS new_customers
FROM `dbt_BrandonHoeft.customers`
GROUP BY signup_week
ORDER BY signup_week