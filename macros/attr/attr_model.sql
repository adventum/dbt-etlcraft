{%- macro attr_model(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}

{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}
{%- set attribution_models = metadata['attribution_models'] -%}
{%- set model_list = funnels[funnel_name].models -%}

{%- set model_info = {} -%}  {# Создаем пустой словарь для хранения информации о моделях #}
{% for model in model_list %}
    {%- set _ = model_info.update({attribution_models[model].type: attribution_models[model].fields}) -%}
{% endfor %}

{#- 
SELECT 
{{ model_list }}
выводит ['my_first_model', 'my_second_model']
{{model_info}}
выводит {'last_click': ['utmSource', 'utmMedium', 'utmCampaign', 'utmTerm', 'utmContent', 'adSourceDirty'], 'first_click': ['utmSource', 'utmMedium', 'utmCampaign', 'utmTerm', 'utmContent', 'adSourceDirty']}
-#}



with
max_last_click_rank as (

    select
        *
{% for model_type in model_info %}
        ,max({{'__'~ model_type ~ '_rank' }}) over(partition by qid, __period_number order by __datetime, __priority, __id) as {{'__max_' ~ model_type ~ '_rank' }}
{%  endfor %}

     from {{ ref('attr_' ~funnel_name~ '_join_to_attr_prepare_with_qid') }}

),

target_count as (

    select
        *
{% for model_type in model_info %}
         ,{{'__'~ model_type ~ '_rank' }} = {{'__max_' ~ model_type ~ '_rank' }} as  {{'__' ~ model_type ~ '__rank_condition' }}
         ,sum(case when {{'__' ~ model_type ~ '__rank_condition' }} then 1 else 0 end) over(partition by qid, __period_number order by __datetime, __priority, __id) as {{'__' ~ model_type ~ '__target_count' }} 
{%  endfor %}
    from max_last_click_rank
)

SELECT 
    qid, __datetime, __id, __priority,`__if_missed`,__link,__period_number,__step

{% for model_type, fields in model_info.items() %}
    {% if model_type == 'last_click' %}
        {% for field in fields %}
            ,first_value({{field}}) over(partition by qid, __period_number, {{'__' ~ model_type ~ '__target_count' }}  order by  __datetime, __priority, __id) as {{'__' ~  funnel_name ~'_'~ model_type ~'_'~ field}}
        {% endfor %}
    {% elif model_type == 'first_click' %}
        {% for field in fields %}
            ,first_value({{field}}) over(partition by qid, __period_number order by {{'__' ~ model_type ~ '_rank' }} desc,__datetime, __priority, __id) as {{'__' ~  funnel_name ~'_'~ model_type ~ '_'~ field}}
        {% endfor %}
    {%  endif %} 
{% endfor %}

 FROM target_count







{% endmacro %}