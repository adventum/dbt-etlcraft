-- depends_on: test.incremental_appmetrica_registry_default_profiles
SELECT
    appmetrica_device_id AS appmetricaDeviceId,
    profile_id AS crmUserId,
    city AS cityName,
    '' AS utmHash,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality('AppProfileMatching') AS __link 
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_registry_default_profiles' as String) as _dbt_source_relation,

                
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_registry_default_profiles

            
        )

        )



