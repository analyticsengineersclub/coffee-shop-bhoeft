with unique_customer as (

    select 
        customer_id,
        date_trunc(first_order_at, week) first_order_at_week
    from {{ ref('customers') }}
    
)

, unique_date_week as (

    select distinct date_week -- multiple date_week doops per date_day
    from {{ ref('dim_dates') }}

)

, customer_spine as(

    -- each row is incrementing (customer_id, week) from week of their first order
    -- until the week of the latest global customer order/pageview
    select 
        uw.date_week, 
        uc.customer_id
    from unique_date_week uw
    cross join unique_customer uc
    where uw.date_week >= uc.first_order_at_week

)

, customer_weekly_revenue as (

    select 
        ordered_at_week,
        customer_id, 
        sum(product_price) as revenue
    from {{ ref('sales_breakdown') }}
    group by ordered_at_week, customer_id, customer_name

)

, customer_ltv as (

    select 
        cs.customer_id,
        cs.date_week,
        coalesce(r.revenue, 0) as revenue,
        sum(coalesce(r.revenue, 0)) over (partition by cs.customer_id order by cs.date_week asc) cumulative_revenue
    from customer_spine cs
    left join customer_weekly_revenue r on cs.customer_id = r.customer_id
                                        and cs.date_week = r.ordered_at_week
)

select *
from customer_ltv