
        
  
    
    
        
        insert into test.incremental_sheets_periodstat_default_planCosts__dbt_new_data_e511c210_fafe_4da5_81d4_73537699fec3 ("__date", "Campaign", "Cost", "Period_end", "Period_start", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_sheets_periodstat_default_planCosts

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_sheets_periodstat_default_planCosts

  
      