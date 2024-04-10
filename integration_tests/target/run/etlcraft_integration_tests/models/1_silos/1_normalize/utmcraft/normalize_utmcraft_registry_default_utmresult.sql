

  create view test.normalize_utmcraft_registry_default_utmresult__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'created_at') AS created_at, 
JSONExtractString(_airbyte_data, 'created_by_id') AS created_by_id, 
JSONExtractString(_airbyte_data, 'data') AS data, 
JSONExtractString(_airbyte_data, 'form_id') AS form_id, 
JSONExtractString(_airbyte_data, 'id') AS id, 
JSONExtractString(_airbyte_data, 'updated_at') AS updated_at, 
JSONExtractString(_airbyte_data, 'updated_by_id') AS updated_by_id, 
JSONExtractString(_airbyte_data, 'utm_hashcode') AS utm_hashcode,
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_utmcraft_registry_default_testaccount_utmresult' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_utmcraft_registry_default_testaccount_utmresult

            
        )

        )
  )