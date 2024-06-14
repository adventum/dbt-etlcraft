{%- macro graph_edge(
  params = none,
  override_target_metadata=none,
  stage_name=none,
  limit0=none
  ) -%}

{# 
    Настройка материализации данных.
    materialized='table' указывает, что данные будут материализованы в таблицу.
    post_hook указывает на необходимость выполнения действия после завершения загрузки данных.
    Здесь используется post_hook для вставки данных из graph_edge в целевую таблицу с заменой.
#}
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

{# 
    Создание временной таблицы join_left для хранения соединения между уникальными ключами и узлами.
    Происходит соединение таблицы graph_tuples с таблицей graph_unique по ключам.
#}
with join_left as (
    select key_number as node_id_left, node_left
    from {{ ref('graph_tuples') }} x
    join {{ ref('graph_unique') }}  y on x.hash = y.key_hash
)

{# 
    Выборка данных для графа, где каждому уникальному ключу соответствует один узел и одна группа.
#}
select node_id_left, key_number as node_id_right, node_id_left as group_id, 1 as has_changed 
from join_left x
join {{ ref('graph_unique') }}  y on x.node_left = y.key_hash
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}