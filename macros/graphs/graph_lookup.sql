{%- macro graph_lookup(
  params = none,
  override_target_metadata=none,
  stage_name=none,
  limit0=none
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('key_number') определяет порядок сортировки данных по ключевому номеру.
#}
{{
    config(
        materialized='table',
        order_by=('key_number')
    )
}}

{# Создание временной таблицы с уникальными ключами #}
with all_keys as
(
    {# 
        Выбор уникальных хэшей из результатов макроса graph_tuples 
        и объединение их с уникальными узлами.
    #}
    select distinct hash as key_hash from {{ ref('graph_tuples') }}
    union distinct select distinct node_left as key_hash from {{ ref('graph_tuples') }}
)

{# Выборка всех ключей и присвоение им номера #}
select *, row_number() over() as key_number from all_keys
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}