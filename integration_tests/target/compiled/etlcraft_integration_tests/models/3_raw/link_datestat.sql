-- depends_on: test.hash_datestat
SELECT __date,reportType,accountName,__table_name,adSourceDirty,adCampaignName,adId,utmSource,utmMedium,utmCampaign,utmTerm,utmContent,utmHash,adTitle1,adText,SUM(adCost) AS adCost,SUM(impressions) AS impressions,SUM(clicks) AS clicks,__emitted_at,__link,adGroupName,adPhraseId,AdCostStatHash,UtmHashHash,__id,__datetime 
FROM test.hash_datestat
GROUP BY __date, reportType, accountName, __table_name, adSourceDirty, adCampaignName, adId, utmSource, utmMedium, utmCampaign, utmTerm, utmContent, utmHash, adTitle1, adText, __emitted_at, __link, adGroupName, adPhraseId, AdCostStatHash, UtmHashHash, __id, __datetime

