with
    orders as (
        select
            customer_id,
            min(order_date) as first_order_date,
            max(order_date) as most_recent_order_date,
            count(order_id) as number_of_orders,
            sum(amount) as lifetime_value
        from {{ ref("fct_orders") }}
        group by customer_id
    )
select
    customer_id,
    first_name,
    last_name,
    first_order_date,
    most_recent_order_date,
    coalesce(number_of_orders, 0) as number_of_orders,
    coalesce(lifetime_value, 0) as lifetime_value,
from {{ ref("stg_jaffle_shop__customers") }}
left join orders using (customer_id)
