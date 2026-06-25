with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

success_payments as (
    select * from {{ ref('stg_stripe__payments') }}
    where payment_status = 'success'
)

select 
    o.customer_id,
    o.order_id,
    sp.payment_amount as amount
from
    orders o join success_payments sp
    on o.order_id = sp.order_id