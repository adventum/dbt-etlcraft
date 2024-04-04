{%- macro attr_create_events(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}

 
{{
    config(
        materialized='table',
        order_by=('qid', '__datetime','__link','__id')
    )
}}


{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}
{%- set step_name_list = funnels[funnel_name].steps -%}
{%- set steps = metadata['steps'] -%}

select
    qid, 
    __link,
    CASE
    {% for step_name in step_name_list %}
        {%- set counter = loop.index -%}
        {%- for step_info in steps[step_name] -%}
            WHEN __link = '{{step_info.link}}' {% if 'condition' in step_info %} and {{step_info.condition}} {% endif %} THEN  {{ counter }}
        {% endfor %}
    {% endfor %}
    ELSE 0
    END as __priority, 
    __id,
    __datetime,
    toLowCardinality(
    CASE
    {% for step_name in step_name_list %}
        {%- for step_info in steps[step_name] -%}
            WHEN __link = '{{step_info.link}}' THEN '{{step_name}}'
        {% endfor %}
    {% endfor %}
    END) as __step
 from {{ ref('attr_' ~funnel_name~ '_prepare_with_qid') }}


{% endmacro %}