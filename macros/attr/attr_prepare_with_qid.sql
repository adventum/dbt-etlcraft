{%- macro attr_prepare_with_qid(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}


{{
    config(
        materialized='table',
        order_by=('qid', '__datetime','__link','__id')
    )
}}

select
    y.qid, x.*
from {{ ref('hash_events') }} as x
left join {{ ref('graph_qid') }} as y
    using (__datetime,__link, __id)


{% endmacro %}