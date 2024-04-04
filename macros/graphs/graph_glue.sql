{%- macro graph_glue(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}


{{
    config(
        materialized='table',
        order_by=('node_id_left'),
        pre_hook="{{ etlcraft.calc_graph() }}"
    )
}}

select 
    node_id_left,
    max(group_id) as qid
from {{ ref('graph_edge') }}
group by node_id_left


{% endmacro %}
