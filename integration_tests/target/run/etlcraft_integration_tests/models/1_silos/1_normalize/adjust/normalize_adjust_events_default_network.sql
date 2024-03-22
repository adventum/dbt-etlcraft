

  create view test.normalize_adjust_events_default_network__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'date') AS __date, 
JSONExtractString(_airbyte_data, 'clicks') AS clicks, 
JSONExtractString(_airbyte_data, 'country') AS country, 
JSONExtractString(_airbyte_data, 'country_code') AS country_code, 
JSONExtractString(_airbyte_data, 'date') AS date, 
JSONExtractString(_airbyte_data, 'events') AS events, 
JSONExtractString(_airbyte_data, 'impressions') AS impressions, 
JSONExtractString(_airbyte_data, 'installs') AS installs, 
JSONExtractString(_airbyte_data, 'network') AS network, 
JSONExtractString(_airbyte_data, 'rejected_installs') AS rejected_installs, 
JSONExtractString(_airbyte_data, 'sessions') AS sessions,
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_adjust_events_default_testaccount_network' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_adjust_events_default_testaccount_network

            
        )

        )
  )