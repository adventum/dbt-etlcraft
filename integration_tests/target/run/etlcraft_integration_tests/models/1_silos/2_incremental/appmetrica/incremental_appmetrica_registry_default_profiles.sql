
  
    
    
        
        insert into test.incremental_appmetrica_registry_default_profiles__dbt_backup ("__clientName", "__productName", "appmetrica_device_id", "city", "profile_id", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_registry_default_profiles


SELECT *
FROM (

        (
            select
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("appmetrica_device_id") as appmetrica_device_id ,
                            toString("city") as city ,
                            toString("profile_id") as profile_id ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_appmetrica_registry_default_profiles
        )

        )

  