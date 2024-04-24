
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_sheets_periodstat_default_planCosts
