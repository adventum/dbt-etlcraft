{%- macro multiver__attr_calculate_period_number(
  params = none,
  override_target_metadata=none,
  funnel_name=none,
  limit0=none
  ) -%}

select
    *,
    {% for funnel_name in funnels %}
    {%- if not loop.last %}
        sum(toInt32({{funnel_name ~ '__is_new_period'}})) over (partition by qid order by  {{funnel_name ~ '__rn'}}) AS  {{funnel_name ~ '__period_number'}}, 
    {% else %}   
        sum(toInt32({{funnel_name ~ '__is_new_period'}})) over (partition by qid order by  {{funnel_name ~ '__rn'}}) AS  {{funnel_name ~ '__period_number'}}
    {% endif %}
    {% endfor %}
    

from {{ ref('attr_find_new_period') }}
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}