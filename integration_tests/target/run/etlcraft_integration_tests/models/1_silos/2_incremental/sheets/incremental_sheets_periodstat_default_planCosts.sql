
        
  
    
    
        
        insert into test.incremental_sheets_periodstat_default_planCosts__dbt_tmp ("__date", "Campaign", "Cost", "Period_end", "Period_start", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_sheets_periodstat_default_planCosts

  
    