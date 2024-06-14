{%- macro multiver__attr_create_events(
  params = none,
  override_target_metadata=none,
  funnel_name=none,
  limit0=none
  ) -%}


{{
    config(
        materialized='table',
        order_by=('qid', '__datetime','__link','__id')
    )
}}


{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}


select
    qid, 
    __link,   
{% for funnel_name in funnels %}
    CASE
    {%- set funnel_steps = funnels[funnel_name] -%}
    {%- for step in funnel_steps -%}
        {%- set counter = loop.index -%}
        {%- for  key, value in step.items() -%}
            {%- for item in value -%}
                {%- for sub_key, sub_value in item.items() -%}
                    {% if sub_key == 'link' %} 
                        WHEN __link = '{{sub_value}}' {% if 'condition' in item %} and {{ item['condition'] }}  {% endif %} THEN  {{ counter }}
                    {%- endif -%}
                {%- endfor -%}
            {%- endfor -%}
        {%- endfor -%}
    {% endfor %}
    END as {{funnel_name ~ '__priority'}},
{% endfor %}
        
        __id,
        __datetime,
 from {{ ref('attr_prepare_with_qid') }}
{% if limit0 %}
LIMIT 0
{%- endif -%}


{% endmacro %}