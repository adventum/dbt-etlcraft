
  
    
    
        
        insert into test.full_datestat__dbt_backup ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "productName", "adCampaignName", "adGroupName", "adId", "adPhraseId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adTitle2", "adText", "adPhraseName", "adCost", "impressions", "clicks", "__emitted_at", "__link", "AdCostStatHash", "__id", "__datetime")
  


SELECT 
*EXCEPT(_dbt_source_relation)
FROM  test.hash_datestat
  