-- depends_on: test.hash_events
-- depends_on: test.graph_qid




select
    y.qid, x.*
from test.hash_events as x
left join test.graph_qid as y
    using (__datetime,__link, __id)




