with point_of_sale as (

    select * from {{ ref('point_of_sale') }}

)

, core_products as(

    select * from {{ ref('products') }}

)

, core_customers as (

    select * from {{ ref('customers') }}

)

, sales_breakdown as (

    select
        s.order_id,
        s.product_id,
        s.order_items_id,
        s.customer_id,
        s.ordered_at,
        date_trunc(s.ordered_at, day) as ordered_at_day,
        date_trunc(s.ordered_at, week) as ordered_at_week,
        date_trunc(s.ordered_at, month) as ordered_at_month,
        c.customer_name,
        case 
            when s.ordered_at = c.first_order_at then TRUE 
            else FALSE
        end as customer_is_new,
        p.product_price,
        p.product_category,
        p.product_name
    from point_of_sale s
    inner join core_customers c on s.customer_id = c.customer_id
    inner join core_products p on s.product_id = p.product_id
        and s.ordered_at between p.price_created_at and p.price_ended_at

) 

select *
from sales_breakdown