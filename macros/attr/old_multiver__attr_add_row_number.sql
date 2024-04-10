{%- macro multiver__attr_add_row_number(
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
select
    * ,
    {% for funnel_name in funnels %}
    {%- if not loop.last %}
        row_number() over (partition by qid order by __datetime, {{funnel_name ~ '__priority'}},  __id) AS  {{funnel_name ~ '__rn'}},
    {% else %}   
        row_number() over (partition by qid order by __datetime, {{funnel_name ~ '__priority'}},  __id) AS {{funnel_name ~ '__rn'}}
    {% endif %}
    {% endfor %}

from {{ ref('attr_create_events') }}

{% endmacro %}