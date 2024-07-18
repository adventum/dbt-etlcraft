
  
    
    
        
        insert into test.incremental_utmcraft_registry_default_utmresult__dbt_tmp ("created_at", "created_by_id", "data", "form_id", "id", "updated_at", "updated_by_id", "utm_hashcode", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_utmcraft_registry_default_utmresult


SELECT * 

FROM test.normalize_utmcraft_registry_default_utmresult
  