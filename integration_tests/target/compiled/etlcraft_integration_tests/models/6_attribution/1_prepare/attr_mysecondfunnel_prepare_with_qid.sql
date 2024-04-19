-- depends_on: test.full_events
-- depends_on: test.graph_qid




SELECT
    y.qid, x.*
FROM test.full_events AS x
LEFT JOIN test.graph_qid AS y
    USING (__datetime,__link, __id)




