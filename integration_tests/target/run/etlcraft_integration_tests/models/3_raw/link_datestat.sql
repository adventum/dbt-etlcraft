
  
    
    
        
        insert into test.link_datestat__dbt_backup ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "productName", "adCampaignName", "adGroupName", "adId", "adPhraseId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adTitle2", "adText", "adPhraseName", "adCost", "impressions", "clicks", "__emitted_at", "__link", "AdCostStatHash", "UtmHashHash", "__id", "__datetime")
  -- depends_on: test.hash_datestat
SELECT __date,reportType,accountName,__table_name,adSourceDirty,productName,adCampaignName,adGroupName,adId,adPhraseId,utmSource,utmMedium,utmCampaign,utmTerm,utmContent,utmHash,adTitle1,adTitle2,adText,adPhraseName,adCost,impressions,clicks,__emitted_at,__link,AdCostStatHash,UtmHashHash,__id,__datetime 
FROM test.hash_datestat
GROUP BY __date, reportType, accountName, __table_name, adSourceDirty, productName, adCampaignName, adGroupName, adId, adPhraseId, utmSource, utmMedium, utmCampaign, utmTerm, utmContent, utmHash, adTitle1, adTitle2, adText, adPhraseName, adCost, impressions, clicks, __emitted_at, __link, AdCostStatHash, UtmHashHash, __id, __datetime


  