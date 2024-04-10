
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_mt_datestat_default_banners_statistics
