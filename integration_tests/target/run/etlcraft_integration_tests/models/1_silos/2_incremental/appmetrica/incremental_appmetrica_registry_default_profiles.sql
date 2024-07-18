
  
    
    
        
        insert into test.incremental_appmetrica_registry_default_profiles__dbt_tmp ("__clientName", "__productName", "appmetrica_device_id", "city", "profile_id", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_registry_default_profiles


SELECT * 

FROM test.normalize_appmetrica_registry_default_profiles
  