with sales_breakdown as(
select
    point_of_sale.ordered_at,
    date_trunc(point_of_sale.ordered_at, day) as date_day,
    date_trunc(point_of_sale.ordered_at, week) as date_week,
    date_trunc(point_of_sale.ordered_at, month) as date_month,
    point_of_sale.order_items_id,
    point_of_sale.order_id,
    point_of_sale.product_id,
    point_of_sale.customer_id,
    point_of_sale.customer_is_new,
    product_at_sale.product_price,
    product_at_sale.product_name,
    product_at_sale.product_category
from {{ ref('point_of_sale') }} point_of_sale
left join {{ ref('product_at_sale') }} product_at_sale on point_of_sale.order_items_id = product_at_sale.order_items_id
)

select * from sales_breakdown