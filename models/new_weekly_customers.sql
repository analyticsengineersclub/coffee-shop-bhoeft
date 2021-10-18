SELECT 
    -- week defined: begins Monday, ends day before next begin date
    date_trunc(first_order_at, WEEK(MONDAY)) AS first_order_week,
    COUNT(customer_id) AS customer_cnt
FROM `dbt_BrandonHoeft.customers`
GROUP BY first_order_week
ORDER BY first_order_week