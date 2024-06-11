-- depends_on: test.normalize_mt_datestat_default_banners_statistics



SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM normalize_mt_datestat_default_banners_statistics

