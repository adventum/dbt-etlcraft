{%- macro attr_add_row_number(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}


{{
    config(
        materialized='table',
        order_by=('qid', '__datetime', '__link', '__id')
    )
}}


select
    * ,
        row_number() over (partition by qid order by __datetime, __priority,  __id) AS  __rn

from {{ ref('attr_' ~ funnel_name ~ '_create_events') }}

{% endmacro %}