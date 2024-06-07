-- depends_on: test.normalize_sheets_periodstat_default_planCosts

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_sheets_periodstat_default_planCosts
