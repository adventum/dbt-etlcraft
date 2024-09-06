{%- macro multiver__attr_find_new_period(
  params = none,
  override_target_metadata=none,
  funnel_name=none,
  limit0=none
  ) -%}


{{
    config(
        materialized='table',
        order_by=('qid', '__datetime', '__link', '__id')
    )
}}

{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}

with prep_new_period as (

    select
        *,
        {% for funnel_name in funnels %}
        {%- if not loop.last %}
             max(case when {{funnel_name ~ '__priority'}} in (0,1,2,3,4,5) then __datetime else null end) over (partition by qid order by  {{funnel_name ~ '__rn'}} rows between unbounded preceding and 1 preceding) as  {{funnel_name ~ 'prep_new_period'}},
        {% else %}   
            max(case when {{funnel_name ~ '__priority'}} in (0,1,2,3,4,5) then __datetime else null end) over (partition by qid order by  {{funnel_name ~ '__rn'}} rows between unbounded preceding and 1 preceding) as  {{funnel_name ~ 'prep_new_period'}}
        {% endif %}
        {% endfor %}
    from {{ ref('attr_add_row_number') }}

)

select
    qid, __link,
    __id,
    __datetime,
    {% for funnel_name in funnels %}
    {%- if not loop.last %}
            {{funnel_name ~ '__rn'}},
            {{funnel_name ~ '__priority'}},
            if(toDate(__datetime) - toDate({{funnel_name ~ 'prep_new_period'}}) < 90, false, true) as {{funnel_name ~ '__is_new_period'}} ,
    {% else %}   
            {{funnel_name ~ '__rn'}},
            {{funnel_name ~ '__priority'}},
            if(toDate(__datetime) - toDate({{funnel_name ~ 'prep_new_period'}}) < 90, false, true) as {{funnel_name ~ '__is_new_period'}}
    {% endif %}
    {% endfor %}
 from prep_new_period   
{% if limit0 %}
LIMIT 0
{%- endif -%}


{% endmacro %}