{%- macro attr_find_new_period(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}


{{
    config(
        materialized='table',
        order_by=('qid', '__datetime', '__link', '__id')
    )
}}
{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}
{%- set step_name_list = funnels[funnel_name].steps -%}
{%- set counter = [] -%}
{%- set steps = metadata['steps'] -%}

{%- for step_name in step_name_list -%}
     {%- do counter.append(loop.index) -%}
{% endfor %}


with prep_new_period as (

    select
        *,
             max(case when __priority in {{counter}} then __datetime else null end) over (partition by qid order by  __rn rows between unbounded preceding and 1 preceding) as  prep_new_period
    from {{ ref('attr_' ~funnel_name~ '_add_row_number') }}

)

select
    qid, __link,
    __priority,
    __id,
    __datetime,
    __rn,
    __step,
    CASE
    {% for step_name in step_name_list %}
    {%- set counter = loop.index -%}
        {% for step_info in steps[step_name] %}
            WHEN __link = '{{step_info.link}}' and toDate(__datetime) - toDate(prep_new_period) < 
            {% if 'period' in step_info %} {{step_info.period}} {% else %} 90 {% endif %} THEN false
        {% endfor %}
    {%- endfor -%}
    ELSE true
    END as __is_new_period
 from prep_new_period   



{% endmacro %}