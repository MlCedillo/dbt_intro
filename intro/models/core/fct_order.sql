{{
    config(
        materialized='incremental',
        on_schema_change='ignore'
    )
}}

select
    o.id::integer as order_id,
    o.user_id as customer_id,
    c.customer_sk,
    o.order_date::date as order_date,
    o.status,
    o.dbt_scd_id,
    o.dbt_updated_at::datetime as dbt_updated_at,
    o.dbt_valid_from::datetime as dbt_valid_from,
    coalesce(o.dbt_valid_to::datetime, '9999-12-31') as dbt_valid_to,
from
    {{ ref('snp_orders') }} as o
left join
    {{ ref('dim_customers') }} as c
    on o.user_id = c.customer_id
    and o.dbt_updated_at >= c.dbt_valid_from
    and o.dbt_updated_at < c.dbt_valid_to

{% if is_incremental() %}
-- this filter will only be applied on an incremental run
-- (uses >= to include records whose timestamp occurred since the last run of this model)
where
    o.dbt_valid_from::datetime >= (select max(dbt_valid_from::datetime) from {{ this }})
{% endif %}
