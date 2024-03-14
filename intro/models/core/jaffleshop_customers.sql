--- customers
--
--
{{
    config(
        materialized='table'
    )
}}


select
    id::integer as customer_id,
    first_name,
    last_name,
    postal_code::integer as postal_code
from
  {{ source('jaffleshop', 'jaffleshop_customers') }}