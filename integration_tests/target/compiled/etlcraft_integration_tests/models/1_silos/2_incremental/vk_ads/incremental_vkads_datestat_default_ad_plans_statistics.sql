
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_vkads_datestat_default_ad_plans_statistics
