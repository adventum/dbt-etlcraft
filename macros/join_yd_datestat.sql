{%- macro join_yd_datestat(
    sourcetype_name,
    pipeline_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{%- set sourcetype_name = 'yd' -%}
{%- set pipeline_name = 'datestat' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+'  -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 

WITH cmps AS (
SELECT * FROM {{ source_table }}
{%- if date_from and  date_to %} 
WHERE toDate(__date) BETWEEN '{{date_from}}' AND '{{date_to}}'
{%- endif -%}
)

SELECT  
    toDate(__date) AS __date,
    toLowCardinality('*') AS reportType, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    'Yandex Direct Ads' AS adSourceDirty,
    '' AS productName,
    CampaignName AS adCampaignName,
    CampaignType AS adGroupName,
    CampaignId AS adId,
    '' AS adPhraseId,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    arrayElement(splitByChar('~', CampaignName), 2) AS utmHash,
    '' AS adTitle1,
    '' AS adTitle2,
    '' AS adText,
    '' AS adPhraseName,  
    (toFloat64(Cost)/1000000)*1.2 AS adCost,
    toInt32(Impressions) AS impressions,
    toInt32(Clicks) AS clicks,
    __emitted_at
FROM cmps


{% endmacro %}