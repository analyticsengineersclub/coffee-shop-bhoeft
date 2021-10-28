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

, core_customers as(

    select * from {{ ref('customers') }}

)

, point_of_sale as(

select
    order_items.order_items_id,
    order_items.order_id,
    order_items.product_id,
    orders.customer_id,
    orders.ordered_at,
    core_customers.first_order_at,
    case 
        when orders.ordered_at = core_customers.first_order_at then TRUE 
        else FALSE
    end as customer_is_new
from order_items
inner join orders on order_items.order_id = orders.order_id
left join core_customers on orders.customer_id = core_customers.customer_id

)

select *
from point_of_sale
order by ordered_at DESC, order_id, product_id