
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_yd_default_cmps
