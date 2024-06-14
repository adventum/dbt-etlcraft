-- depends_on: test.attr_mysecondfunnel_find_new_period




select
    *,
    sum(toInt32(__is_new_period)) over (partition by qid order by __rn) AS __period_number
from test.attr_mysecondfunnel_find_new_period



