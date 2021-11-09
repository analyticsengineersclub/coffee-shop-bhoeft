with order_items as(
    
    select
        order_items_id,
        order_id,
        product_id
    from {{ ref('stg_coffee_shop__order_items') }}

)

, orders as(

    select 
        order_id,
        customer_id,
        ordered_at
    from {{ ref('stg_coffee_shop__orders') }}

)

, point_of_sale as(

    select
        order_items.order_items_id,
        order_items.order_id,
        order_items.product_id,
        orders.customer_id,
        orders.ordered_at,
    from order_items
    left join orders on order_items.order_id = orders.order_id

)

select *
from point_of_sale