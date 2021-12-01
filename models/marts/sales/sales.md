{% docs sales_breakdown %}

This sales team facing model (Week 3) enables answering sales specific questions such as "What is our weekly revenue by new vs returning customers?" or "What is our monthly revenue by product category?". This model is derived from a star schema (point_of_sale, products, customers, dim_dates)

{% enddocs %}


{% docs customer_weekly_ltv %}

This sales team facing model (Week 4), creates pre-calculated cumulative revenue values for all of our customers for each week starting with the week of their first order. Its goal is to enable easy development of customer lifetime value curves (a.k.a. average cumulative revenue) to enable cohorted, cumulative revenue analytics. 

{% enddocs %}
