
        
  
    
    
        
        insert into test.incremental_sheets_periodstat_default_planCosts__dbt_new_data_e73065dd_cb2b_48cf_898d_f49bff11cfc3 ("__date", "Campaign", "Cost", "Period_end", "Period_start", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_sheets_periodstat_default_planCosts

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_sheets_periodstat_default_planCosts

  
      