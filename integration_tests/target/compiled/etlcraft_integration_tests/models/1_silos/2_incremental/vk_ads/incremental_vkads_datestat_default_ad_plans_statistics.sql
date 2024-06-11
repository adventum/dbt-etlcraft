-- depends_on: test.normalize_vkads_datestat_default_ad_plans_statistics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM normalize_vkads_datestat_default_ad_plans_statistics

