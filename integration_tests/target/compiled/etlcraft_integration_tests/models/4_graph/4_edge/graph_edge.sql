-- depends_on: test.graph_unique
-- depends_on: test.graph_tuples




with join_left as (
    select key_number as node_id_left, node_left
    from test.graph_tuples x
    join test.graph_unique  y on x.hash = y.key_hash
)


select node_id_left, key_number as node_id_right, node_id_left as group_id, 1 as has_changed 
from join_left x
join test.graph_unique  y on x.node_left = y.key_hash



