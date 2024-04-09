{%- macro attr_prepare_with_qid(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('qid', '__datetime','__link','__id') определяет порядок сортировки данных по идентификатору группы, дате, ссылке и идентификатору.
#}
{{
    config(
        materialized='table',  
        order_by=('qid', '__datetime','__link','__id')  
    )
}}

{# 
    Выборка данных из таблицы hash_events с добавлением идентификаторов группы из ранее созданной таблицы graph_qid.
#}
select
    y.qid, x.*
from {{ ref('hash_events') }} as x
left join {{ ref('graph_qid') }} as y
    using (__datetime,__link, __id)

{% endmacro %}