
  
    
    
        
        insert into test.incremental_mt_registry_default_banners__dbt_tmp ("__clientName", "__productName", "campaign_id", "id", "textblocks", "urls", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_mt_registry_default_banners


SELECT * 

FROM test.normalize_mt_registry_default_banners
  