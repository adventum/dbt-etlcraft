{%- macro create_dataset(
  funnel = none,
  conditions = none,
  override_target_metadata=none,
  override_target_model_name=none
  ) -%}


{%- set relations = []-%}

{# возможно стоит добавить pipeline в funnels из metadata #}

{% for condition in conditions %}
  {% if condition.pipeline == 'events' %}
      {%- set ref =  'attr_' ~ funnel  ~ '_final_table' -%}
      {%- do relations.append(ref) -%}
  {% else %}
      {%- set ref =  'full_' ~ condition.pipeline  -%}
      {%- do relations.append(ref) -%}
  {%- endif -%}  
{%- endfor -%}

{%- set unique_relations = relations|unique|list -%}
{%- set source_table = '(' ~ etlcraft.custom_union_relations( relations=[ref('full_datestat'), ref('attr_myfirstfunnel_final_table')]) ~ ')' -%}
{{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}

{%- set source_field = "splitByChar('_', __table_name)[4]" -%}
{%- set preset_field = "splitByChar('_', __table_name)[6]" -%}
{%- set account_field = "splitByChar('_', __table_name)[7]" -%}

{% for condition in conditions %}
  {% if loop.last %}
    SELECT * FROM {{ source_table }} 
    WHERE 
    {{source_field}} = '{{condition.source}}'
    and 
    {{account_field}} = '{{condition.account}}'
    and 
    {{preset_field}} = '{{condition.preset}}'
  {% else %}
    SELECT * FROM {{ source_table }} 
    WHERE 
    {{source_field}} = '{{condition.source}}'
    and 
    {{account_field}} = '{{condition.account}}'
    and 
    {{preset_field}} = '{{condition.preset}}'
    UNION ALL
  {%- endif -%}  
{%- endfor -%}


{% endmacro %}