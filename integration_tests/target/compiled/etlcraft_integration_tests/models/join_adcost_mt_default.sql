


WITH banners_statistics AS (
SELECT * FROM test.incremental_mt_default_banners_statistics 
WHERE toDate(__datetime) BETWEEN '2024-01-05' AND '2024-01-18'),

banners AS (
SELECT * FROM test.incremental_mt_default_banners
),

campaigns AS (
SELECT * FROM test.incremental_mt_default_campaigns
)

SELECT 
    toDate(banners_statistics.__datetime) AS __datetime,
    toLowCardinality('*') AS reportType,  
    toLowCardinality(splitByChar('_', banners_statistics.__table_name)[6]) AS accountName,
    banners_statistics.__table_name AS __table_name,
    'MyTarget' AS adSourceDirty,
    '' AS productName,
    campaigns.name AS adCampaignName,
    '' AS adGroupName,
    banners.id AS adId,
    '' AS adPhraseId,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_source=([^&]*)') AS utmSource,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_medium=([^&]*)') AS utmMedium,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_term=([^&]*)') AS utmTerm,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_content=([^&]*)') AS utmContent,
    JSON_VALUE(replaceAll(banners.textblocks, '''', '"'), '$.title_25.text') AS adTitle1,
    '' AS adTitle2,
    assumeNotNull(coalesce(nullif(JSON_VALUE(replaceAll(banners.textblocks, '''', '"'), '$.text_90.text'), ''),
    JSON_VALUE(replaceAll(banners.textblocks, '''', '"'), '$.text_220.text'), '')) AS adText,
    '' AS adPhraseName,
    toFloat64(JSONExtractString(banners_statistics.base, 'spent')) AS adCost,
    toInt32(JSONExtractString(banners_statistics.base, 'shows')) AS impressions,
    toInt32(JSONExtractString(banners_statistics.base, 'clicks')) AS clicks
FROM banners_statistics
JOIN banners ON banners_statistics.banner_id = banners.id 
JOIN campaigns ON banners.campaign_id = campaigns.id








