-- depends_on: test.normalize_yd_datestat_default_custom_report



SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM normalize_yd_datestat_default_custom_report

