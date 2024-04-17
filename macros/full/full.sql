{%- macro full(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none) 
-%}

{#- задаём части имени - выясняем какой у нас pipeline: datestat/events/periodstat -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set pipeline_name = model_name_parts[1] -%}


{#- задаём список возможных таблиц registry -#}
{%- set registry_possible_tables = [
    'link_appmetrica_registry', 
    'link_utmcraft_registry', 
    'link_abcd_registry'
    ] -%}

{#- отбираем те из них, которые существуют -#}
{%- set registry_existing_tables = [] -%}
{%- for table_ in registry_possible_tables -%}
    {%- set table_exists = etlcraft.clickhouse__check_table_exists(source_table=table_, database=this.schema) -%}
    {%- if table_exists == 1 -%} 
    {%- do registry_existing_tables.append(table_) -%}
    {%- endif -%} 
{%- endfor -%}

{#-  для отобранных таблиц создаём relations, чтобы сделать к ним запрос  -#}
{%- set relations_registry = [] -%}    
{%- for table_ in registry_existing_tables -%}
    {%- set fields = ref( table_ ) -%}
    {%- do relations_registry.append(fields) -%}
{%- endfor -%} 

{#- задаём переменную, где находятся все имеющиеся таблицы пайплайна registry и шага link -#}
{%- set link_registry_tables = etlcraft.custom_union_relations(relations=relations_registry) -%}

{#- для пайплайна events делаем материализацию table и соединяем данные link_events??? + graph_qid + имеющиеся registry -#}
{%- if pipeline_name =='events' -%} 
{{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}

SELECT * 
FROM (
    SELECT * FROM {{ ref('link_events') }}
    LEFT JOIN {{ ref('graph_qid') }} USING (__id, __link, __datetime)
) t1
LEFT JOIN {{ link_registry_tables }} t2 USING (__id, __link, __datetime)

{#- без link_events вот такой запрос 
SELECT * 
FROM {{ ref('graph_qid') }}  t1
LEFT JOIN {{ link_registry_tables }} t2 USING (__id, __link, __datetime)
-#}

{#- для пайплайна datestat делаем материализацию incremental и соединяем данные link_datestat + имеющиеся registry -#}
{%- elif pipeline_name =='datestat' -%} 
{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}
SELECT * 
FROM {{ ref('link_datestat') }} t1
LEFT JOIN {{ link_registry_tables }} t2 USING (__id, __link, __datetime)


{%- endif -%} 
{% endmacro %}