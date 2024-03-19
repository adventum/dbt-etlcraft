{%- macro hash(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none
  ) -%}

{%- if execute -%}

{#- задаём части имени - pipeline это например datestat -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set pipeline_name = model_name_parts[1] -%}

{#- если имя модели не соответсвует шаблону - выдаём ошибку -#}
{%- if model_name_parts|length < 2 or model_name_parts[0] != 'hash' -%}
{{ exceptions.raise_compiler_error('Model name "' ~ this.name ~ '" does not follow the expected pattern: "hash_{pipeline_name}"') }}
{%- endif -%}

{#- задаём паттерн, чтобы найти combine-таблицу нужного пайплайна -#}
{%- set table_pattern = 'combine_' ~ pipeline_name -%}  

{#- находим все таблицы, которые соответствут паттерну -#}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, 
                                                              table_pattern=table_pattern) -%} 

{#- если что-то не так - выдаём ошибку -#}                                                                  
{%- if not relations -%}
{{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". Please ensure that your source data follows the expected structure.') }}
{%- endif -%}

{#- собираем одинаковые таблицы, которые будут проходить по этому макросу  - здесь union all найденных таблиц -#}
{%- set source_table = '(' ~ etlcraft.custom_union_relations(relations) ~ ')' -%}

{#- узнаём список присутствующих в таблице линков, задав запрос -#}
{%- set query -%}
        SELECT DISTINCT __link
        FROM {{ source_table }} 
{%- endset -%}
{#- и из этого запроса берём список -#}
{%- set links_list = run_query(query).columns[0].values() -%}

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}

{% set metadata = fromyaml(etlcraft.metadata()) %}

SELECT 
    *, 
       {% for link in links_list %}
        {{ etlcraft.link_hash(link, metadata) }},
    {% endfor %}
    {{ etlcraft.entity_hash('UtmHash', metadata) }}  

FROM {{ source_table }} 
WHERE {{ link ~ 'Hash' != ''}}
{#-  
{% for link in links_list %}
        {% if not loop.last %}
            {{ link ~ 'Hash' != ''}}
            {{ AND }}
        {% endif %}
        {% else %}
             {{ link ~ 'Hash' != '' }}
      {% endfor %}
-#}


{%- endif -%}
{% endmacro %}