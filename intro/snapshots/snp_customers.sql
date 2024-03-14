-- snapshot para customers
--
{% snapshot snp_customers %}

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
    {{ source('jaffleshop', 'jaffleshop_customers') }}

{% endsnapshot %}