{%- macro graph_unique(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}

{{
    config(
        materialized='table',
        order_by=('key_hash')
    )
}}

select * from {{ ref('graph_lookup') }}


{% endmacro %}