
SELECT * 
REPLACE(toDate(__datetime, 'UTC') AS __date)
FROM test.normalize_yd_datestat_default_cmps
