{%- macro graph_edge(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}

{{
    config(
        materialized='table',
        post_hook= {
            'sql': 'insert into {{target.schema}}.graph_edge(node_id_left, node_id_right, group_id, has_changed)
                    select
                        node_id_right,
                        node_id_left,
                        group_id,
                        has_changed
                    from {{target.schema}}.graph_edge;'
        }
    )
}}
with join_left as (
 select key_number as node_id_left, node_left
  from {{ ref('graph_tuples') }} x
  join {{ ref('graph_unique') }}  y on x.hash = y.key_hash )
  
select node_id_left, key_number as node_id_right, node_id_left as group_id, 1 as has_changed 
  from join_left x
  join {{ ref('graph_unique') }}  y on x.node_left = y.key_hash

{% endmacro %}


