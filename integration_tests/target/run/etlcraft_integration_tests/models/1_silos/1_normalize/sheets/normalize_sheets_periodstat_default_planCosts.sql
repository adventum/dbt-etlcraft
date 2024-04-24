

  create view test.normalize_sheets_periodstat_default_planCosts__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'Period_start') AS __date, 
JSONExtractString(_airbyte_data, 'Campaign') AS Campaign, 
JSONExtractString(_airbyte_data, 'Cost') AS Cost, 
JSONExtractString(_airbyte_data, 'Period_end') AS Period_end, 
JSONExtractString(_airbyte_data, 'Period_start') AS Period_start,
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_sheets_periodstat_default_testaccount_planCosts' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_sheets_periodstat_default_testaccount_planCosts

            
        )

        )
  )