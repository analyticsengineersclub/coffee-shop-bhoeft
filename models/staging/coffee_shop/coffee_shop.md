{% docs __src_coffee_shop__ %}

**Sources** of **coffee_shop** originate in

Google Big Query Project: analytics-engineers-club  

Google Big Query Dataset (Schema): coffee_shop

{% enddocs %}




{% docs src_coffee_shop__customers %}

This table describes each customer. one record equals one customer

{% enddocs %}


{% docs src_coffee_shop__orders %}

This table describes each order. one record equals one order

{% enddocs %}


{% docs src_coffee_shop__order_items %}

This table describes each order item comprising an order. one record equals a product in that order. If multiple of the same product are in that order, that product will have multiple records per that specific order.

{% enddocs %}


{% docs src_coffee_shop__products %}

This table describes each product sold by the coffee shop. one record
equals one product item.

{% enddocs %}


{% docs src_coffee_shop__product_prices %}

This table represents the price of each product between a created and ended at date. one record equals the price of a product between a specific period of time.

{% enddocs %}





{% docs __coffee_shop__ %}

# Coffee Shop (Lorem Ipsum)

*"There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."*

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum pharetra porta. Sed maximus nunc libero, in venenatis eros imperdiet mattis. Maecenas sit amet felis vehicula, fringilla neque vitae, porta ligula. Suspendisse potenti. Phasellus id volutpat felis. Vestibulum sit amet sapien a erat porttitor dignissim. In hac habitasse platea dictumst. Mauris tincidunt quis neque id ullamcorper. Ut a nibh id odio aliquam ultricies. Sed euismod diam et est efficitur, vitae ullamcorper sapien mollis. Quisque velit nibh, dignissim nec justo id, consequat porttitor erat. Maecenas eleifend dui a arcu suscipit, eu varius neque cursus. Vestibulum id accumsan tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum dignissim at enim nec ultrices.

{% enddocs %}



{% docs stg_customers %}

This staging view takes raw data from its like-named source table, cleans up some column names for analysis. one record equals one customer

{% enddocs %}

{% docs stg_orders %}

This staging view takes raw data from its like-named source table, cleans up some column names for analysis. one record equals one order

{% enddocs %}

{% docs stg_order_items %}

This staging view takes raw data from its like-named source table, cleans up some column names for analysis. one record equals one product in a given order. If multiple of the same product are in the order, the product will have multiple records per that specific order, differing in their unique order_items_id.

{% enddocs %}

{% docs stg_products %}

This staging view takes raw data from its like-named source table, cleans up some column names for analysis. one record equals one product

{% enddocs %}

{% docs stg_product_prices %}

This staging view takes raw data from its like-named source table, cleans up some column names for analysis. one record equals the price of a product between a specific period of time.

{% enddocs %}
