{%- macro attr_calculate_period_number(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}

select
    *,
    sum(toInt32(__is_new_period)) over (partition by qid order by __rn) AS  __period_number

    
from {{ ref('attr_' ~funnel_name~ '_find_new_period') }}


{% endmacro %}