{% test is_positive(model, column_name) %}

    -- write query that returns any records that fail your assumption 
    select *
    from {{ model }}
    where {{ column_name }} <= 0

{% endtest %}

