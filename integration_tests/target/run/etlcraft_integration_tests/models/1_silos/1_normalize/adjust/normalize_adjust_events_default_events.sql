

  create view test.normalize_adjust_events_default_events__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'app_token') AS app_token, 
JSONExtractString(_airbyte_data, 'description') AS description, 
JSONExtractString(_airbyte_data, 'formatting') AS formatting, 
JSONExtractString(_airbyte_data, 'id') AS id, 
JSONExtractString(_airbyte_data, 'is_skad_event') AS is_skad_event, 
JSONExtractString(_airbyte_data, 'name') AS name, 
JSONExtractString(_airbyte_data, 'section') AS section, 
JSONExtractString(_airbyte_data, 'short_name') AS short_name, 
JSONExtractString(_airbyte_data, 'tokens') AS tokens,
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_adjust_events_default_testaccount_events' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_adjust_events_default_testaccount_events

            
        )

        )
  )