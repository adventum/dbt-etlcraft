{%- macro full(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none) 
-%}

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
 
 {{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}

 SELECT * 
 FROM {{ ref('graph_qid') }} t1
 LEFT JOIN {{ link_registry_tables }} t2 USING (__id, __link, __datetime)

{% endmacro %}