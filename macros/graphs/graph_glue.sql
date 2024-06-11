{%- macro graph_glue(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('node_id_left') определяет порядок сортировки данных по идентификатору узла слева.
    pre_hook="{{ etlcraft.calc_graph() }}" указывает на необходимость выполнения предварительного хука etlcraft.calc_graph() перед выполнением запроса.
#}
{{
    config(
        materialized='table',
        order_by=('node_id_left'),
        pre_hook="{{ etlcraft.calc_graph() }}"
    )
}}

{# 
    Выборка уникальных идентификаторов узлов слева и их максимального идентификатора группы из ранее созданной таблицы graph_edge.
    Группировка по идентификатору узла слева.
#}
select 
    node_id_left,
    min(group_id) as qid
from {{ ref('graph_edge') }}
group by node_id_left

{% endmacro %}