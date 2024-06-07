
  
    
    
        
        insert into test.incremental_mt_registry_default_campaigns__dbt_backup ("__clientName", "__productName", "id", "name", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_mt_registry_default_campaigns


SELECT *
FROM normalize_mt_registry_default_campaigns

  