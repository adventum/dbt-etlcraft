{%- macro attr_prepare_with_qid(
  params = none,
  model_name=none,
  limit0=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('qid', '__datetime','__link','__id') 
    определяет порядок сортировки данных по идентификатору группы, дате, ссылке и идентификатору.
#}
{{
    config(
        materialized='table',  
        order_by=('qid', '__datetime','__link','__id')  
    )
}}

{#- 
    Выборка данных из таблицы full_events с добавлением идентификаторов группы из ранее созданной таблицы graph_qid.
-#}

WITH full_events_without_qid AS (
SELECT *EXCEPT(qid) FROM {{ ref('full_events') }}
)

SELECT y.qid, x.*
FROM full_events_without_qid AS x
LEFT JOIN {{ ref('graph_qid') }} AS y
    USING (__datetime,__link, __id)

{#- было вот так и было два столбца: y.qid, qid - от этого в дальнейшем возникала ошибка в dataset_event_table
SELECT
    y.qid, x.*
FROM {{ ref('full_events') }} AS x
LEFT JOIN {{ ref('graph_qid') }} AS y
    USING (__datetime,__link, __id) -#}
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}