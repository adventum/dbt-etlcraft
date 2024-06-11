{%- macro incremental(
    defaults_dict=etlcraft.etlcraft_defaults(), 
    disable_incremental=False) -%}

{#- задаём имя модели через имеющееся имя файла -#}
{%- set model_name = this.name -%}

{#- если имя модели не соответсвует шаблону - выдаём ошибку -#}
{#- Verify the naming convention of the model -#}
{%- if not model_name.startswith('incremental_') -%}
    {{ exceptions.raise_compiler_error("Model name does not match the expected naming convention: 'incremental_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}'.") }}
{%- endif -%}

{#- выводим имя модели normalize - это понадобится для FROM в запросе -#}
{#- Derive the normalized relation's name from the incremental model's name -#}
{%- set model_name_parts = model_name.split('_') -%}

{#- задаём переменные - источник, пайплайн, шаблон, поток, и паттерн собранный из них -#}
{%- set sourcetype_name = model_name_parts[1] -%}
{%- set pipeline_name = model_name_parts[2] -%}
{%- set template_name = model_name_parts[3] -%}
{%- set stream_name_parts = model_name_parts[4:] -%}
{%- set stream_name = '_'.join(stream_name_parts) -%}
{%- set table_pattern = 'normalize_' ~ sourcetype_name ~ '_' ~ pipeline_name ~ '_' ~ template_name ~ '_' ~ stream_name -%}

{%- if pipeline_name in ('registry', 'periodstat') -%}
{%- set disable_incremental=true -%}
{%- endif -%}

{#- задаём инкрементальное поле с датой если его нет -#}
{#- Determine the incremental datetime field (IDF) if not provided -#}
{%- if disable_incremental -%}
    {%- set incremental_datetime_field = False -%}    
{%- else -%}
  {%- set incremental_datetime_field = etlcraft.find_incremental_datetime_field([], table_pattern, defaults_dict=defaults_dict, do_not_throw=True) -%}
{%- endif -%}

{#- если инкрементальное поле с датой так и не установлено, будем делать SELECT * -#}
{#- If IDF is not found, treat this as a simple proxy -#}
{%- if incremental_datetime_field == False  -%}

    {{ config(
        materialized='table',
        order_by=('__table_name'),
        on_schema_change='fail'
    ) }}

SELECT * 

{#- If IDF exists, create an incremental model -#}
{#- ниже - то, что будет в модели -#}
{%- else -%}
    {{ config(
        materialized='incremental',
        order_by=('__date', '__table_name'),
        incremental_strategy='delete+insert',
        unique_key=['__date', '__table_name'],
        on_schema_change='fail'
    ) }}
SELECT * 
REPLACE({{ etlcraft.cast_date_field('__date') }} AS __date)   
{%- endif %}
FROM {{ table_pattern }}
{% endmacro %}