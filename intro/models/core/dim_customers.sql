--- dim_customer (snp)
---
---

select
    id::integer as customer_id,
    dbt_scd_id as customer_sk,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    postal_code::integer as postal_code,
    dbt_updated_at::datetime as dbt_updated_at,
    dbt_valid_from::datetime as dbt_valid_from,
    coalesce(dbt_valid_to::datetime, '9999-12-31') as dbt_valid_to
from
    {{ ref('snp_customers') }}
      
