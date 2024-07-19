-- depends_on: test.graph_qid
-- depends_on: test.link_events
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry

WITH t0 AS (
SELECT * FROM test.link_events
LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
)
, t1 AS ( 
SELECT t0.*, link_registry_utmhashregistry.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link) 
FROM t0 
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT t1.*, link_registry_appprofilematching.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link) 
FROM t1 
LEFT JOIN link_registry_appprofilematching USING (AppMetricaDeviceHash,CrmUserHash) 
) 
SELECT COLUMNS('^[^.]+$') FROM t2 
