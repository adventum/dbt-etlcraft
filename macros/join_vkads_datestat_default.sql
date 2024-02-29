{%- macro join_vkads_datestat_default(
    sourcetype_name,
    pipeline_name,
    template_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

WITH ad_plans_statistics AS (
SELECT * FROM {{ ref('incremental_vkads_datestat_default_ad_plans_statistics') }}
{%- if date_from and  date_to %} 
WHERE toDate(__date) between '{{date_from}}' and '{{date_to}}'
{%- endif -%}
),

ad_plans AS (
SELECT * FROM {{ ref('incremental_vkads_datestat_default_ad_plans') }}
)

SELECT
    toDate(ad_plans_statistics.__date) AS __date,
    toLowCardinality('') AS reportType,
    toLowCardinality(splitByChar('_', ad_plans.__table_name)[6]) AS accountName,
    toLowCardinality(ad_plans.__table_name) AS __table_name,
    'VK Ads' AS adSourceDirty,
    '' AS productName,
    ad_plans.name AS adCampaignName,
    '' AS adGroupName,
    ad_plans.id AS adId,
    '' AS adPhraseId,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    '' AS utmHash,
    '' AS adTitle1,
    '' AS adTitle2,
    '' AS adText,
    '' AS adPhraseName,  
    toFloat64(JSONExtractString(ad_plans_statistics.base, 'spent'))* 1.2 AS adCost,
    toInt32(JSONExtractString(ad_plans_statistics.base, 'shows')) AS impressions,
    toInt32(JSONExtractString(ad_plans_statistics.base, 'clicks')) AS clicks,
    ad_plans.__emitted_at AS __emitted_at
FROM ad_plans
JOIN ad_plans_statistics ON ad_plans.id = ad_plans_statistics.ad_plan_id



{% endmacro %}