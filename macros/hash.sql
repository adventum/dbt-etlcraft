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

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}

{% set metadata = fromyaml(etlcraft.metadata()) %}

{#- задаём список всех линков -#}
{% set links = metadata['links'] %}
{% set links_list = [] %}
{#- отбираем те линки, у которых значение pipeline совпадает с именем pipeline модели - т.е отбираем нужные -#}
{% for link_name in links  %}
    {% set link_pipeline = links[link_name].get('pipeline') %}
    {% if link_pipeline == pipeline_name %}
        {% do links_list.append(link_name) %}
    {%- endif -%} 
{%- endfor -%}

{#-
Этот запрос
SELECT  {{ links_list }}
для hash_datestat выводит ['AdCostStat']
для hash_events выводит ['AppInstallStat', 'AppEventStat', 'AppSessionStat', 'AppDeeplinkStat', 'VisitStat', 'AppProfileMatching']
-#}

{#- основной запрос -#} 
SELECT 
    *, 
       {% for link in links_list %}
        {{ etlcraft.link_hash(link, metadata) }},  {# добавляем хэши для отобранных линков #}
    {% endfor %}
    {{ etlcraft.entity_hash('UtmHash', metadata) }}  {# здесь можно добавить больше сущностей #}

FROM {{ source_table }} 
WHERE {{ link ~ 'Hash' != ''}}  {# не уверена доконца, что так работает + ниже черновик для бОльшего кол-ва сущностей #}
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

-- SETTINGS short_circuit_function_evaluation=force_enable

{%- endif -%}
{% endmacro %}