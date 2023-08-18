{% macro incremental(defaults_dict=etlcraft.etlcraft_defaults(), disable_incremental=False) %}

{% set model_name = this.name %}

{# Verify the naming convention of the model #}
{% if not model_name.startswith('incremental_') %}
    {{ exceptions.raise_compiler_error("Model name does not match the expected naming convention: 'incremental_{sourcetypename}_{templatename}_{streamname}'.") }}
{% endif %}

{# Derive the normalized relation's name from the incremental model's name #}
{% set model_name_parts = model_name.split('_') %}
{% set normalized_relation_name = 'normalize_' + model_name_parts[1] + '_' + model_name_parts[2] + '_' + '_'.join(model_name_parts[3:]) %}

{# Determine the incremental datetime field (IDF) if not provided #}
{% if disable_incremental %}
    {% set incremental_datetime_field = False %}    
{% else %}
  {% set incremental_datetime_field = etlcraft.find_incremental_datetime_field([], normalized_relation_name, defaults_dict=defaults_dict, do_not_throw=True) %}
{% endif %}


{# If IDF is not found, treat this as a simple proxy #}
{% if incremental_datetime_field == False  %}
    SELECT * 
{# If IDF exists, create an incremental model #}
{% else %}
    
    {{ config(
        materialized='incremental',
        order_by=('__datetime', '__table_name'),
        incremental_strategy='delete+insert',
        unique_key=['__datetime', '__table_name']
    ) }}

    SELECT * REPLACE({{ etlcraft.cast_datetime_field('__datetime') }} AS __datetime)    
{% endif %}
FROM {{ ref(normalized_relation_name) }}
{% endmacro %}