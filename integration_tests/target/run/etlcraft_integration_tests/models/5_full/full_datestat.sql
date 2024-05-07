
        
  
    
    
        
        insert into test.full_datestat__dbt_tmp ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "adCampaignName", "adId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adText", "adCost", "impressions", "clicks", "__emitted_at", "__link", "adGroupName", "adPhraseId", "AdCostStatHash", "UtmHashHash", "__id", "__datetime", "link_registry_utmhashregistry.utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "link_registry_utmhashregistry.__emitted_at", "link_registry_utmhashregistry.__table_name", "link_registry_utmhashregistry.__link", "UtmHashRegistryHash", "link_registry_utmhashregistry.__id", "link_registry_utmhashregistry.__datetime")
  -- depends_on: test.link_datestat
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry
 
WITH t0 AS (
SELECT * FROM test.link_datestat
)
, t1 AS ( 
SELECT * FROM t0
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT * FROM t1
) 
SELECT * FROM t2 





  
    