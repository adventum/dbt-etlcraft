{%- macro join_vkads_datestat(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}

{%- set sourcetype_name = 'vkads' -%}
{%- set pipeline_name = 'datestat' -%}

{%- set stream_name_ad_plans_statistics = 'ad_plans_statistics' -%}
{%- set table_pattern_ad_plans_statistics = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name_ad_plans_statistics ~ '$' -%}
{%- set relations_ad_plans_statistics = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_ad_plans_statistics) -%}   
{%- set source_table_ad_plans_statistics = '(' ~ dbt_utils.union_relations(relations_ad_plans_statistics) ~ ')' -%} 

{%- set stream_name_ad_plans = 'ad_plans' -%}
{%- set table_pattern_ad_plans = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name_ad_plans ~ '$' -%}
{%- set relations_ad_plans = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_ad_plans) -%}   
{%- set source_table_ad_plans = '(' ~ dbt_utils.union_relations(relations_ad_plans) ~ ')' -%}

WITH ad_plans_statistics AS (
SELECT * FROM {{ source_table_ad_plans_statistics }}
{%- if date_from and  date_to %} 
WHERE toDate(__date) between '{{date_from}}' and '{{date_to}}'
{%- endif -%}
),

ad_plans AS (
SELECT * FROM {{ source_table_ad_plans }}
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
    ad_plans.__emitted_at AS __emitted_at,
    toLowCardinality('AdCostStat') AS __link 
FROM ad_plans
JOIN ad_plans_statistics ON ad_plans.id = ad_plans_statistics.ad_plan_id



{% endmacro %}