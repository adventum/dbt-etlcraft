
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_vkads_default_ad_plans_statistics
