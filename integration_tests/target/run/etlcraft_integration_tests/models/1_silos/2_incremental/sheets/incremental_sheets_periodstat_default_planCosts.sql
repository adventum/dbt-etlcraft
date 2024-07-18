
  
    
    
        
        insert into test.incremental_sheets_periodstat_default_planCosts__dbt_tmp ("Campaign", "Cost", "Period_end", "Period_start", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_sheets_periodstat_default_planCosts


SELECT * 

FROM test.normalize_sheets_periodstat_default_planCosts
  