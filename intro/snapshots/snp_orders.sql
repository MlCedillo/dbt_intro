--
--
{% snapshot snp_orders %}

{{
    config(
      target_schema='core',
      unique_key='id',
      strategy='timestamp',
      updated_at='_elt_updated_at'
    )
}}

select
    *
from
    {{ source('jaffleshop', 'jaffleshop_orders') }}

{% endsnapshot %}