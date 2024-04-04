{%- macro graph_qid(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}

{{
    config(
        materialized='table',
        order_by=('__datetime', '__link', '__id'),
        pre_hook="{{ etlcraft.calc_graph() }}"
    )
}}

select  toLowCardinality(
    tupleElement(key_hash, 1)
    ) as __link,
   
    tupleElement(key_hash, 2) as __datetime,
    tupleElement(key_hash, 3) as __id,
    qid
from {{ ref('graph_glue') }}
join {{ ref('graph_lookup') }} on key_number = node_id_left




{% endmacro %}