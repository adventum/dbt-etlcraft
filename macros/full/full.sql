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
    'link_abcd_registry'] -%}

{#- отбираем те из них, которые существуют -#}
{%- set registry_existing_tables = [] -%}
{%- for registry_table in registry_possible_tables -%}
    {%- set table_exists = etlcraft.clickhouse__check_table_exists(source_table=registry_table, database=this.schema) -%}
    {%- if table_exists == 1 -%} 
    {%- do registry_existing_tables.append(registry_table) -%}
    {%- endif -%} 
{%- endfor -%}

{#-  для отобранных таблиц создаём relations, чтобы сделать к ним запрос  -#}
{%- set relations = [] -%}    
{%- for t in registry_existing_tables -%}
{%- set fields = ref( t ) -%}
{%- do relations.append(fields) -%}
{%- endfor -%} 

{%- set link_registry_tables = etlcraft.custom_union_relations(relations=relations) -%}
 
 SELECT * FROM {{ link_registry_tables }} 

{% endmacro %}