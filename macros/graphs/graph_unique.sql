{%- macro graph_unique(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('key_hash') определяет порядок сортировки данных по ключевому хэшу.
#}
{{
    config(
        materialized='table',
        order_by=('key_hash')
    )
}}

{# Выборка всех уникальных ключей из ранее созданной таблицы graph_lookup #}
select * from {{ ref('graph_lookup') }}

{% endmacro %}