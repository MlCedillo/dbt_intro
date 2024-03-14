--- customer_orders
---
---

{{
    config(
        materialized='table'
    )
}}

select
    c.customer_id,
    count(1) as n_orders
from
    {{ ref('jaffleshop_customers') }} as c
left join
    {{ ref('jaffleshop_orders') }} as o
    on c.customer_id = o.customer_id
group by
 c.customer_id