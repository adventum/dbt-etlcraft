-- depends_on: test.link_datestat
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry
 
WITH t0 AS (
SELECT * FROM test.link_datestat
)
, t1 AS ( 
SELECT t0.*, link_registry_utmhashregistry.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link) 
FROM t0 
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT * 
FROM t1
) 
SELECT COLUMNS('^[^.]+$') FROM t2