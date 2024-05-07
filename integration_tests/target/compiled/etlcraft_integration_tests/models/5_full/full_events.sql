-- depends_on: test.graph_qid
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry

WITH t0 AS (
SELECT * FROM test.link_events
LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
)
, t1 AS ( 
SELECT * FROM t0
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT * FROM t1
LEFT JOIN link_registry_appprofilematching USING (AppMetricaDeviceHash,CrmUserHash) 
) 
SELECT * FROM t2 




