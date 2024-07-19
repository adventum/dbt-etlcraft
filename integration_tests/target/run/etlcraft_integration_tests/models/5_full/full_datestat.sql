
        
  
    
    
        
        insert into test.full_datestat__dbt_new_data_087659a2_aa28_455d_8cec_34f515445ad6 ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "adCampaignName", "adId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adText", "adCost", "impressions", "clicks", "__emitted_at", "__link", "adGroupName", "adPhraseId", "AdCostStatHash", "UtmHashHash", "__id", "__datetime", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash")
  -- depends_on: test.link_datestat
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry
 
WITH t0 AS (
SELECT * FROM test.link_datestat
)
, t1 AS ( 
SELECT t0.*, link_registry_utmhashregistry.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link) 
FROM t0 
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT * 
FROM t1
) 
SELECT COLUMNS('^[^.]+$') FROM t2 

  
      