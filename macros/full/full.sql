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

{#- для пайплайна events делаем материализацию table и соединяем данные link_events + graph_qid + имеющиеся registry -#}
{%- if pipeline_name =='events' -%} 
{{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}
{# делаем пошагово, чтобы из результата убрать колонки, начинающиеся как t2.<название колонки> #}
WITH t1 AS (
SELECT * FROM {{ ref('link_events') }}
LEFT JOIN {{ ref('graph_qid') }} USING (__id, __link, __datetime)
)
, t2 AS (
SELECT * FROM {{ link_registry_tables }}
)
, t3 AS (
SELECT * 
FROM t1
LEFT JOIN t2 USING (__id, __link, __datetime)
)
SELECT * EXCEPT(`t2.__emitted_at`, `t2.__table_name`, `t2.appmetricaDeviceId`, `t2.crmUserId`, 
`t2.cityName`, `t2.utmHash`, `t2.UtmHashHash`, `t2.AppMetricaDeviceHash`, `t2.CrmUserHash`)
FROM t3

{# такой вариант не работает - дублирующиеся колонки всё равно есть
SELECT * EXCEPT(`t2.__emitted_at`, `t2.__table_name`, `t2.appmetricaDeviceId`, `t2.crmUserId`, 
`t2.cityName`, `t2.utmHash`, `t2.UtmHashHash`, `t2.AppMetricaDeviceHash`, `t2.CrmUserHash`)
FROM (
    SELECT * FROM {{ ref('link_events') }}
    LEFT JOIN {{ ref('graph_qid') }} USING (__id, __link, __datetime)
) t1
LEFT JOIN (SELECT * FROM {{ link_registry_tables }}) t2 USING (__id, __link, __datetime) #}


{#- для пайплайна datestat делаем материализацию incremental и соединяем данные link_datestat + имеющиеся registry -#}
{%- elif pipeline_name =='datestat' -%} 
{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}

WITH t1 AS (
SELECT * FROM {{ ref('link_datestat') }}
)
, t2 AS (
SELECT * FROM {{ link_registry_tables }}
)
, t3 AS (
SELECT * FROM t1
LEFT JOIN t2 USING (__id, __link, __datetime)
)
SELECT * EXCEPT(`t2.__emitted_at`, `t2.__table_name`, `t2.utmHash`, `t2.UtmHashHash`)
FROM t3

{# такой вариант не работает, дублирующиеся колонки всё равно есть 
SELECT * EXCEPT(`t2.__emitted_at`, `t2.__table_name`, `t2.utmHash`, `t2.UtmHashHash`)
FROM {{ ref('link_datestat') }} t1
LEFT JOIN (SELECT * FROM {{ link_registry_tables }}) t2 USING (__id, __link, __datetime) #}


{#- для пайплайна periodstat делаем материализацию incremental и разбиваем метрики по дням -#}
{%- elif pipeline_name =='periodstat' -%}  

{#-
{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}  -#}

{#- задаём наименования числовых типов данных -#}
{%- set numeric_types = ['UInt8', 'UInt16', 'UInt32', 'UInt64', 'UInt256', 
                        'Int8', 'Int16', 'Int32', 'Int64', 'Int128', 'Int256',
                        'Float8', 'Float16','Float32', 'Float64','Float128', 'Float256','Num'] -%} 

{%- set columns_numeric = [] -%}
{%- set columns_not_numeric = [] -%}
{%- set source_columns = adapter.get_columns_in_relation(load_relation(ref('link_periodstat'))) -%}


{%- for c in source_columns -%}
{%- if c.data_type in numeric_types -%}
{%- do columns_numeric.append(c.name)  -%}
{%- else -%}
{%- do columns_not_numeric.append(c.name)  -%}
{%- endif -%}
{%- endfor -%} 

WITH unnest_dates AS (
SELECT *, 
    dateAdd(periodStart, arrayJoin(range( 0, 1 + toUInt16(date_diff('day', periodStart, periodEnd))))) AS period_date
	, COUNT(*) OVER(PARTITION BY 
{% for c in columns_not_numeric -%}{{c}}
{% if not loop.last %},{% endif %}
{% endfor %} 
    ) AS divide_by_days
FROM {{ ref('link_periodstat') }}
)
SELECT period_date, 
{% for column in columns_not_numeric -%}{{column}},
{% endfor %} 
{% for column in columns_numeric -%}{{column}}/divide_by_days AS {{column}}_per_day
{% if not loop.last %},{% endif %}
{% endfor %} 

FROM unnest_dates


{%- endif -%} 
{% endmacro %}