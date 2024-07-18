
  
    
    
        
        insert into test.link_registry_utmhashregistry__dbt_backup ("utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "__emitted_at", "__table_name", "__link", "UtmHashRegistryHash", "UtmHashHash", "__id", "__datetime")
  -- depends_on: test.hash_registry_utmhashregistry
SELECT utmHash,utm_base_url,utm_utmSource,utm_utmMedium,utm_utmCampaign,utm_project,utm_utmContent,utm_strategy,utm_audience,__emitted_at,__table_name,__link,UtmHashRegistryHash,UtmHashHash,__id,__datetime 
FROM test.hash_registry_utmhashregistry
GROUP BY utmHash, utm_base_url, utm_utmSource, utm_utmMedium, utm_utmCampaign, utm_project, utm_utmContent, utm_strategy, utm_audience, __emitted_at, __table_name, __link, UtmHashRegistryHash, UtmHashHash, __id, __datetime

  