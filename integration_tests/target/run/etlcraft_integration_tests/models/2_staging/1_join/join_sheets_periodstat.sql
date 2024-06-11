
  
    
    
        
        insert into test.join_sheets_periodstat__dbt_backup ("campaign", "cost", "periodStart", "periodEnd", "__emitted_at", "__table_name", "__link")
  -- depends_on: test.incremental_sheets_periodstat_default_planCosts
SELECT
    Campaign AS campaign,
    toFloat64(Cost) AS cost,
    toDate(Period_start) AS periodStart,
    toDate(Period_end) AS periodEnd,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name, 
    toLowCardinality('ManualAdCostStat') AS __link

FROM (
    

        (
            select
                cast('test.incremental_sheets_periodstat_default_planCosts' as String) as _dbt_source_relation,

                
                    cast("Campaign" as String) as "Campaign" ,
                    cast("Cost" as String) as "Cost" ,
                    cast("Period_end" as String) as "Period_end" ,
                    cast("Period_start" as String) as "Period_start" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_sheets_periodstat_default_planCosts

            
        )

        )


  