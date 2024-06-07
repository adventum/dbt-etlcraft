
        
  
    
    
        
        insert into test.incremental_sheets_periodstat_default_planCosts__dbt_new_data_257a9f0c_75e4_425f_88c2_849703901296 ("__date", "Campaign", "Cost", "Period_end", "Period_start", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_sheets_periodstat_default_planCosts

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("Campaign") as Campaign ,
                            toString("Cost") as Cost ,
                            toString("Period_end") as Period_end ,
                            toString("Period_start") as Period_start ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_sheets_periodstat_default_planCosts
        )

        )

  
      