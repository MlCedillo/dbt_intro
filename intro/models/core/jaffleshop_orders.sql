--- orders
--
--
{{
    config(
        materialized='table'
    )
}}


select

    ID ::integer as order_id,
	USER_ID as customer_id,
	ORDER_DATE:: date as order_date,
	STATUS 

from
  {{ source('jaffleshop', 'jaffleshop_orders') }}