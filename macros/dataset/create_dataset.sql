{%- macro create_dataset(
  funnel = none,
  conditions = none,
  override_target_metadata=none,
  override_target_model_name=none
  ) -%}

{#- возможно стоит добавить pipeline в funnels из metadata -#}

{%- set patterns = [] -%} {# сюда будем собирать паттерны названий таблиц, к-ые нам будут нужны #}
{% for condition in conditions %}
  {% if condition.pipeline == 'events' %}
      {%- set pattern =  'attr_' ~ funnel  ~ '_final_table' -%}
  {% else %}
      {%- set pattern =  'full_' ~ condition.pipeline  -%}
  {%- endif -%}  
  {% if pattern not in patterns %} {# сразу заботимся об уникальности списка #}
    {% do patterns.append(pattern) %}
  {%- endif -%} 
{%- endfor -%}

{%- set relation_list = [] -%} {# сюда будем собирать их relations #}
{%- for i in range(patterns|length) -%}
  {%- do relation_list.append(ref(patterns[i])) -%}
{%- endfor -%}

{#- передаём полученный список relations сюда, и получаем таблицу, с которой будем работать -#}
{% set source_table = '(' ~ etlcraft.custom_union_relations(relations=relation_list) ~ ')' %} 

{#- делаем материализацию table -#}
{{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}

{#- задаём переменные для дальнейшего прописывания условий -#}
{%- set source_field = "splitByChar('_', __table_name)[4]" -%}
{%- set preset_field = "splitByChar('_', __table_name)[6]" -%}
{%- set account_field = "splitByChar('_', __table_name)[7]" -%}

{#- генерируем SQL-запрос для каждого condition, указанного пользователем, с нужными с условиями -#}
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