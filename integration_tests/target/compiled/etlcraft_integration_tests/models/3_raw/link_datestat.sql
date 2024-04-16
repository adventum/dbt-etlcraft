-- depends_on: test.hash_datestat
SELECT _dbt_source_relation,None,__date,reportType,accountName,__table_name,adSourceDirty,productName,adCampaignName,adGroupName,adId,adPhraseId,utmSource,utmMedium,utmCampaign,utmTerm,utmContent,utmHash,adTitle1,adTitle2,adText,adPhraseName,adCost,impressions,clicks,__emitted_at,__link,AdCostStatHash,__id,__datetime 
FROM test.hash_datestat
GROUP BY _dbt_source_relation, None, __date, reportType, accountName, __table_name, adSourceDirty, productName, adCampaignName, adGroupName, adId, adPhraseId, utmSource, utmMedium, utmCampaign, utmTerm, utmContent, utmHash, adTitle1, adTitle2, adText, adPhraseName, adCost, impressions, clicks, __emitted_at, __link, AdCostStatHash, __id, __datetime

