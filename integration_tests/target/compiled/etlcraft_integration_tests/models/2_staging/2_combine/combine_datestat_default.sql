-- depends_on: test.join_mt_datestat_default
-- depends_on: test.join_vkads_datestat_default
-- depends_on: test.join_yd_datestat_default


SELECT 
    __date,
    toLowCardinality(reportType) AS reportType,  
    toLowCardinality(accountName) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality(adSourceDirty) AS adSourceDirty,
    productName,
    adCampaignName,
    adGroupName,
    adId,
    adPhraseId,
    utmSource,
    utmMedium,
    utmCampaign,
    utmTerm,
    utmContent,
    utmHash,
    adTitle1,
    adTitle2,
    adText,
    adPhraseName,
    adCost,
    impressions,
    clicks,
    __emitted_at
FROM test.join_mt_datestat_default
UNION ALL
SELECT 
    __date,
    toLowCardinality(reportType) AS reportType,  
    toLowCardinality(accountName) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality(adSourceDirty) AS adSourceDirty,
    productName,
    adCampaignName,
    adGroupName,
    adId,
    adPhraseId,
    utmSource,
    utmMedium,
    utmCampaign,
    utmTerm,
    utmContent,
    utmHash,
    adTitle1,
    adTitle2,
    adText,
    adPhraseName,
    adCost,
    impressions,
    clicks,
    __emitted_at
FROM test.join_vkads_datestat_default
UNION ALL
SELECT 
    __date,
    toLowCardinality(reportType) AS reportType,  
    toLowCardinality(accountName) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality(adSourceDirty) AS adSourceDirty,
    productName,
    adCampaignName,
    adGroupName,
    adId,
    adPhraseId,
    utmSource,
    utmMedium,
    utmCampaign,
    utmTerm,
    utmContent,
    utmHash,
    adTitle1,
    adTitle2,
    adText,
    adPhraseName,
    adCost,
    impressions,
    clicks,
    __emitted_at
FROM test.join_yd_datestat_default


