{%- macro attr_calculate_period_number(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('qid', '__datetime', 'record_source', '__id') определяет порядок сортировки данных по идентификатору группы, дате, источнику записи и идентификатору.
#}
{{
    config(
        materialized='table',
        order_by=('qid', '__datetime', 'record_source', '__id')
    )
}}

{# 
    Вычисление номера периода для каждой группы (qid).
    Суммирование значения __is_new_period для каждой строки в группе дает номер текущего периода.
#}
select
    *,
    sum(toInt32(__is_new_period)) over (partition by qid order by __rn) AS __period_number
from {{ ref('attr_' ~funnel_name~ '_find_new_period') }}

{% endmacro %}
