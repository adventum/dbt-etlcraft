

  create view test.normalize_adjust_events_default_cohorts__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'date') AS __date, 
        JSONExtractString(_airbyte_data, 'country') AS country, 
        JSONExtractString(_airbyte_data, 'date') AS date, 
        JSONExtractString(_airbyte_data, 'event_name') AS event_name, 
        JSONExtractString(_airbyte_data, 'event_token') AS event_token, 
        JSONExtractString(_airbyte_data, 'events') AS events, 
        JSONExtractString(_airbyte_data, 'network') AS network, 
        JSONExtractString(_airbyte_data, 'period') AS period, 
        JSONExtractString(_airbyte_data, 'tracker_token') AS tracker_token,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_adjust_events_default_testaccount_cohorts') AS _dbt_source_relation,
        toString("_airbyte_ab_id") AS _airbyte_ab_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_emitted_at") AS _airbyte_emitted_at 
FROM test._airbyte_raw_adjust_events_default_testaccount_cohorts
)

)
  )