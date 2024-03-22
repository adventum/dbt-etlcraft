{%- macro join(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none
  ) -%}

{%- if execute -%}

{#- задаём части имени -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set sourcetype_name = model_name_parts[1] -%}
{%- set pipeline_name = model_name_parts[2] -%}

{#- получаем список incremental таблиц и их полей в формате table_name: [field1,field2, ... fieldn] -#}
{%- set relations_dict =  etlcraft.get_relations_dict('incremental',sourcetype_name) -%}

{%- if not disable_incremental %}
{#- получаем список date_from:xxx[0], date_to:yyy[0] из union всех normalize таблиц -#}
  {%- set min_max_date_dict = etlcraft.get_min_max_date('normalize',sourcetype_name) -%}
  {%- set date_from = min_max_date_dict.get('date_from')[0] -%}
  {%- set date_to = min_max_date_dict.get('date_to')[0] -%}
    {{ config(
        materialized='incremental',
        order_by=('__date', '__table_name'),
        incremental_strategy='delete+insert',
        unique_key=['__date', '__table_name'],
        on_schema_change='fail'
    ) }}
{%- endif -%}

{#- устанавливаем имя макроса - туда будем перенаправлять исполнение, это название вида джойна -#}
{% set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name %}


{#- здесь перечислены параметры, которые д.б. такими же в каждом виде макроса join -#}
{{ etlcraft[macro_name](sourcetype_name,pipeline_name,relations_dict,date_from,date_to,params)}}

{% endif %}
{% endmacro %}
