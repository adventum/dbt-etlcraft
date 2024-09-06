{%- macro graph_qid(
  params=none,
  stage_name=none,
  limit0=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('__datetime', '__link', '__id') определяет порядок сортировки данных по дате, ссылке и идентификатору.
    pre_hook="{{ etlcraft.calc_graph() }}" указывает на необходимость выполнения предварительного хука etlcraft.calc_graph() перед выполнением запроса.
#}
{{
    config(
        materialized='table', 
        order_by=('__datetime', '__link', '__id'), 
        pre_hook="{{ etlcraft.calc_graph() }}"  
    )
}}

{# 
    Выборка данных для формирования итоговой таблицы.
    Каждому уникальному ключу (__link, __datetime, __id) соответствует qid из ранее созданной таблицы graph_glue.
#}
select  
    toLowCardinality(
        tupleElement(key_hash, 1)
    ) as __link,
    tupleElement(key_hash, 2) as __datetime,
    tupleElement(key_hash, 3) as __id,
    qid
from {{ ref('graph_glue') }}  -- Объединение с таблицей graph_glue
join {{ ref('graph_lookup') }} on key_number = node_id_left  -- Соединение с таблицей graph_lookup
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}