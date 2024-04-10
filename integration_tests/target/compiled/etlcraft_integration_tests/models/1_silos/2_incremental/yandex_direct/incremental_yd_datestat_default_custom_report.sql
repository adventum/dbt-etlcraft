
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_yd_datestat_default_custom_report
