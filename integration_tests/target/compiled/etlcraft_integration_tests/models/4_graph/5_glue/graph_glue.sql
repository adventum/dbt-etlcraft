-- depends_on: test.graph_edge




select 
    node_id_left,
    min(group_id) as qid
from test.graph_edge
group by node_id_left




