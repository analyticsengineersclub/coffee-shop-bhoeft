{% docs new_weekly_customers %}

This view contains new customer counts at a weekly data granularity.

{% enddocs %}


{% docs point_of_sale %}

This view acts as the table of interest in a star schema and has all the keys of interest that are part of the sale occurrence ("point of sale"), which can be used as foreign key
references to other tables/views such as customers and products

{% enddocs %}


{% docs products %}

This view provides descriptions of each product in the coffee_shop and details about the price of the product between start and end dates. It will be useful for breaking down order totals into its component parts for more granular analysis of sales.

{% enddocs %}


{% docs pageviews %}

One record represents a user (logged in customer or unknown user) view of a single page during a visit. For logged in customers (customer_id not null), their visitor_id is stitched, reflecting their first visitor_id.

{% enddocs %}
