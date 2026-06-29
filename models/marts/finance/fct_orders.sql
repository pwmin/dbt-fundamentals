with
    orders as (
        select distinct order_id, order_date, customer_id
        from {{ ref("stg_jaffle_shop__orders") }}
    ),
    payments as (
        select order_id, sum(amount) as amount
        from {{ ref("stg_stripe__payments") }}
        where status ilike 'success'
        group by order_id
    )
select
    order_id,
    order_date,  -- Extra column not specified in original requirements
    customer_id,
    coalesce(amount, 0) as amount
from orders
left join payments using (order_id)
