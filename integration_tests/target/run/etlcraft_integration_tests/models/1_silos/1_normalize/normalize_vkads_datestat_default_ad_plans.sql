

  create view test.normalize_vkads_datestat_default_ad_plans__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'ad_groups') AS ad_groups, 
JSONExtractString(_airbyte_data, 'autobidding_mode') AS autobidding_mode, 
JSONExtractString(_airbyte_data, 'budget_limit') AS budget_limit, 
JSONExtractString(_airbyte_data, 'budget_limit_day') AS budget_limit_day, 
JSONExtractString(_airbyte_data, 'created') AS created, 
JSONExtractString(_airbyte_data, 'date_end') AS date_end, 
JSONExtractString(_airbyte_data, 'date_start') AS date_start, 
JSONExtractString(_airbyte_data, 'id') AS id, 
JSONExtractString(_airbyte_data, 'max_price') AS max_price, 
JSONExtractString(_airbyte_data, 'name') AS name, 
JSONExtractString(_airbyte_data, 'objective') AS objective, 
JSONExtractString(_airbyte_data, 'priced_goal') AS priced_goal, 
JSONExtractString(_airbyte_data, 'pricelist_id') AS pricelist_id, 
JSONExtractString(_airbyte_data, 'status') AS status, 
JSONExtractString(_airbyte_data, 'updated') AS updated, 
JSONExtractString(_airbyte_data, 'vkads_status') AS vkads_status,
        toLowCardinality(_dbt_source_relation) AS __table_name,parseDateTimeBestEffort(_airbyte_emitted_at) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_vkads_datestat_default_new1_ad_plans' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_vkads_datestat_default_new1_ad_plans

            
        )

        union all
        

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
                cast('test._airbyte_raw_vkads_datestat_default_new_ad_plans' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_vkads_datestat_default_new_ad_plans

            
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