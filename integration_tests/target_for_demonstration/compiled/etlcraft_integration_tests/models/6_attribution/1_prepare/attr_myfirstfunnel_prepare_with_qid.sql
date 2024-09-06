-- depends_on: test.full_events
-- depends_on: test.graph_qid

WITH full_events_without_qid AS (
SELECT *EXCEPT(qid) FROM test.full_events
)

SELECT y.qid, x.*
FROM full_events_without_qid AS x
LEFT JOIN test.graph_qid AS y
    USING (__datetime,__link, __id)


