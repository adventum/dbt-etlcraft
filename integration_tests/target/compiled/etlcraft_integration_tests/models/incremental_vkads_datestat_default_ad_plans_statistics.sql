
SELECT * 
REPLACE(toDate(__datetime, 'UTC') AS __date)
FROM test.normalize_vkads_datestat_default_ad_plans_statistics
