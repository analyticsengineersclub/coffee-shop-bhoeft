select
  ordered_at_month as date_month,
  sum(case when product_category = 'coffee beans' then product_price end) as coffee_beans_amount,
  sum(case when product_category = 'merch' then product_price end) as merch_amount,
  sum(case when product_category = 'brewing supplies' then product_price end) as brewing_supplies_amount
from {{ ref('sales_breakdown') }}
group by 1