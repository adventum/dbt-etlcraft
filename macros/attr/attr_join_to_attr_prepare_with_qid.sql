{%- macro attr_join_to_attr_prepare_with_qid(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}



{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}
{%- set attribution_models = metadata['attribution_models'] -%}
{%- set model_list = funnels[funnel_name].models -%}
{%- set step_name_list = funnels[funnel_name].steps -%}
{%- set steps = metadata['steps'] -%}

{%- set model_info = {} -%}  {# Создаем пустой словарь для хранения информации о моделях #}
{% for model in model_list %}
    {%- set _ = model_info.update({attribution_models[model].type: attribution_models[model].priorities}) -%}
{% endfor %}

{{
    config(
        materialized='table',
        order_by=('qid', '__period_number', '__datetime', '__priority', '__id')
    )
}}


select 
    y.__period_number as __period_number, 
    y.__if_missed as __if_missed, 
    y.__priority as __priority, 
    y.__step as __step,
    x.*EXCEPT(adSourceDirty),

{% for model_type, priorities in model_info.items() %}
    CASE
    {% for priority in priorities %}
        {%- set counter = loop.index -%}
        WHEN {{ priority }} THEN {{ counter }}
    {% endfor %}
    ELSE 0
        END as {{ '__'~ model_type ~ '_rank' }},
{% endfor %}

CASE
{% for step_name in step_name_list %}
    {%- set counter = loop.index -%}
    {% for step_info in steps[step_name] %}
         WHEN  __if_missed and __priority = {{ counter }} 
         THEN '{{step_info.if_missed}}'
    {% endfor %}
{% endfor %}
ELSE adSourceDirty
END as adSourceDirty

from {{ ref('attr_' ~funnel_name~ '_prepare_with_qid') }} AS x
join {{ ref('attr_' ~funnel_name~ '_create_missed_steps') }} AS y
    using (qid, __datetime, __link, __id)

{% endmacro %}