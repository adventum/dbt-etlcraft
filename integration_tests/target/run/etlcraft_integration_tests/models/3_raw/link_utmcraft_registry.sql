
  
    
    
        
        insert into test.link_utmcraft_registry__dbt_backup ("utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "__emitted_at", "__table_name", "__link", "UtmHashRegistryHash", "UtmHashHash", "__id", "__datetime")
  -- depends_on: test.hash_utmcraft_registry
SELECT utmHash,utm_base_url,utm_utmSource,utm_utmMedium,utm_utmCampaign,utm_project,utm_utmContent,utm_strategy,utm_audience,__emitted_at,__table_name,__link,UtmHashRegistryHash,UtmHashHash,__id,__datetime 
FROM test.hash_utmcraft_registry
GROUP BY utmHash, utm_base_url, utm_utmSource, utm_utmMedium, utm_utmCampaign, utm_project, utm_utmContent, utm_strategy, utm_audience, __emitted_at, __table_name, __link, UtmHashRegistryHash, UtmHashHash, __id, __datetime


  