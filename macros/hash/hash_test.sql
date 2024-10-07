{%- macro hash_test(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none
  ) -%}


{{ config(
    materialized='table',
    order_by=('__table_name'),
    on_schema_change='fail'
) }}


{%- set metadata = fromyaml(datacraft.metadata()) -%}
{%- set entities_list = [] -%}
{% set registries = metadata['registries'] %} 

{% for registry_name in registries  %}
    {%- set registry_key = registries[registry_name].get('keys') -%}
    {%- set entity_glue = registries[registry_name].get('glue') -%}
    {%- if entity_glue -%}  {# по факту читается как True, поэтому пишем просто if #}
        {%- do entities_list.append(registry_key) -%}
    {%- endif -%} 
{%- endfor -%} 

{%- set final_entities_list = [] -%}
{%- for unique_entity in unique_entities_list  -%}
    {%- if unique_entity in metadata_entities_list -%}
        {%- do final_entities_list.append(unique_entity) -%}
    {%- endif -%}
{%- endfor -%} 


SELECT {{entities_list}}

{% endmacro %}