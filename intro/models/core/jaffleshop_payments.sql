--- payments
--
--
{{
    config(
        materialized='table'
    )
}}


select
    id::integer as payment_id,
    order_id::integer as order_id,
    payment_method as order_date,
    amount::float as amount_usd
    from
    {{ source('jaffleshop', 'jaffleshop_payments') }}