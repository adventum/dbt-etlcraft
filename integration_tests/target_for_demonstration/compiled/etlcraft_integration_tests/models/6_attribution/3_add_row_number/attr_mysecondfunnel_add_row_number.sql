-- depends_on: test.attr_mysecondfunnel_create_events




select
    *,
    row_number() over (partition by qid order by __datetime, __priority, __id) AS __rn
from test.attr_mysecondfunnel_create_events



