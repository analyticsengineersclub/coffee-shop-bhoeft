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
        ordered_at,
        total
    from {{ ref('stg_coffee_shop__orders') }}
)

, products_detail as(
    -- FUTURE FEATURE: consider refactoring this into a stand alone model
    select 
        prod.product_id,
        prod.product_name,
        prod.product_category,
        prodprice.product_price,
        prodprice.price_created_at,
        prodprice.price_ended_at
    from {{ ref('stg_coffee_shop__products') }} prod
    inner join {{ ref('stg_coffee_shop__product_prices') }} prodprice on prod.product_id = prodprice.product_id
)

, product_at_sale as(
select
    order_items.order_items_id,
    order_items.order_id,
    products_detail.product_id,
    orders.ordered_at,
    products_detail.product_name,
    products_detail.product_category,
    products_detail.product_price,
    orders.total,
    products_detail.price_created_at,
    products_detail.price_ended_at
from order_items
left join orders on order_items.order_id = orders.order_id
left join products_detail on order_items.product_id = products_detail.product_id
where orders.ordered_at between products_detail.price_created_at and products_detail.price_ended_at
)

select *
from product_at_sale
order by ordered_at DESC, order_id, product_id