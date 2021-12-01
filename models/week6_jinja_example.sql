{% set product_categories = ['coffee beans', 'merch', 'brewing supplies'] %}

with sales_breakdown as (

  select * from {{ ref('sales_breakdown') }}

)

, product_category_sales_by_month as (

  select
    ordered_at_month as date_month,
    {% for category in product_categories %}
    sum(case when product_category = '{{ category }}' then product_price end) as {{ category | replace(' ', '_') }}_amount
    {% if not loop.last %}
    ,  -- add a comma after all but last new column iteration
    {% endif %}
    {% endfor %}
  from sales_breakdown
  group by 1

)

select * from product_category_sales_by_month