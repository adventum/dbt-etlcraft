

  create view test.normalize_mt_datestat_default_campaigns__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
JSONExtractString(_airbyte_data, '__productName') AS __productName, 
JSONExtractString(_airbyte_data, 'id') AS id, 
JSONExtractString(_airbyte_data, 'name') AS name,
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_mt_datestat_default_testaccount_campaigns' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_mt_datestat_default_testaccount_campaigns

            
        )

        )
  )