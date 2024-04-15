{%- macro combine(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none
  ) -%}

{%- if execute -%}

{#- задаём части имени - pipeline это например datestat -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{#- в combine могут быть модели из 2 или трех частей, но последняя часть всегда обозначает пайплайн -#}
{%- set pipeline_name = model_name_parts[-1] -%}

{#- если имя модели не соответсвует шаблону - выдаём ошибку -#}
{%- if model_name_parts|length < 2 or model_name_parts[0] != 'combine' -%}
{{ exceptions.raise_compiler_error('Model name "' ~ this.name ~ '" does not follow the expected pattern: "combine_{pipeline_name}"') }}
{%- endif -%}

{#- задаём паттерн, чтобы найти все join-таблицы нужного пайплайна -#}
{#- для обычных направлений, состоящих из двух частей имени -#}
{%- if model_name_parts|length < 3 -%}
{%- set table_pattern = 'join' ~ '_[^_]+_' ~ pipeline_name -%} 
{#- для направления registry, где в combine данные должны идти отдельно по типам источника -#}
{%- else -%} 
{%- set sourcetype_name = model_name_parts[1] -%} 
{%- set table_pattern = 'join_' ~ sourcetype_name ~ '_' ~ pipeline_name -%} 
{%- endif -%}

{#- находим все таблицы, которые соответствут паттерну -#}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, 
                                                              table_pattern=table_pattern) -%} 

{#- если что-то не так - выдаём ошибку -#}                                                                  
{%- if not relations -%}
{{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". Please ensure that your source data follows the expected structure.') }}
{%- endif -%}

{#- собираем одинаковые таблицы, которые будут проходить по этому макросу  - здесь union all найденных таблиц -#}

{#- делаем это через кастомный макрос, чтобы null заменить на '' или 0  -#}  {#- relations, source_column_name=None  - без этого ошибка -#}
{%- set source_table = '(' ~ etlcraft.custom_union_relations(relations, source_column_name=None) ~ ')' -%}

{#- если не писать варианты, то делать так - сейчас мы используем этот вариант -#}

SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM {{ source_table }} 
    

{#- если писать варианты, то делать так - сейчас не используем этот вариант
{% set macro_name =  'combine_'~ pipeline_name  %}
{{ etlcraft[macro_name](pipeline_name,relations_dict,date_from,date_to,params)}} -#}

{%- endif -%}
{% endmacro %}


