

  create view test.normalize_vkads_datestat_default_ad_plans_statistics__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'date') AS __date, 
JSONExtractString(_airbyte_data, 'ad_offers') AS ad_offers, 
JSONExtractString(_airbyte_data, 'ad_plan_id') AS ad_plan_id, 
JSONExtractString(_airbyte_data, 'base') AS base, 
JSONExtractString(_airbyte_data, 'carousel') AS carousel, 
JSONExtractString(_airbyte_data, 'events') AS events, 
JSONExtractString(_airbyte_data, 'moat') AS moat, 
JSONExtractString(_airbyte_data, 'playable') AS playable, 
JSONExtractString(_airbyte_data, 'romi') AS romi, 
JSONExtractString(_airbyte_data, 'social_network') AS social_network, 
JSONExtractString(_airbyte_data, 'tps') AS tps, 
JSONExtractString(_airbyte_data, 'uniques') AS uniques, 
JSONExtractString(_airbyte_data, 'uniques_video') AS uniques_video, 
JSONExtractString(_airbyte_data, 'video') AS video,
        toLowCardinality(_dbt_source_relation) AS __table_name,parseDateTimeBestEffort(_airbyte_emitted_at) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_vkads_datestat_default_new1_ad_plans_statistics' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_vkads_datestat_default_new1_ad_plans_statistics

            
        )

        union all
        

        (
            select
                cast('test._airbyte_raw_vkads_datestat_default_new_ad_plans_statistics' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_vkads_datestat_default_new_ad_plans_statistics

            
        )

        )
  )