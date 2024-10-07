{%- macro join_mt_datestat(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params,
    limit0=none
    ) -%}

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}
{%- if execute -%}
{%- set sourcetype_name = 'mt' -%}
{%- set pipeline_name_datestat = 'datestat' -%} 
{%- set pipeline_name_registry = 'registry' -%}

{%- set stream_name_banners_statistics = 'banners_statistics' -%}
{%- set table_pattern_banners_statistics = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_datestat ~  '_[^_]+_' ~ stream_name_banners_statistics ~ '$' -%}
{%- set relations_banners_statistics = datacraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_banners_statistics) -%}   
{%- if not relations_banners_statistics -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern_banners_statistics ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table_banners_statistics = '(' ~ dbt_utils.union_relations(relations_banners_statistics) ~ ')' -%} 
{%- if not source_table_banners_statistics -%} 
    {{ exceptions.raise_compiler_error('No source_table_banners_statistics were found by pattern "' ~ table_pattern_banners_statistics ~ '"') }}
{%- endif -%}

{%- set stream_name_banners = 'banners' -%}
{%- set table_pattern_banners = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_registry ~  '_[^_]+_' ~ stream_name_banners ~ '$' -%}
{%- set relations_banners = datacraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_banners) -%}   
{%- if not relations_banners -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern_banners ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table_banners = '(' ~ dbt_utils.union_relations(relations_banners) ~ ')' -%}
{%- if not source_table_banners -%} 
    {{ exceptions.raise_compiler_error('No source_table_banners were found by pattern "' ~ table_pattern_banners ~ '"') }}
{%- endif -%}

{%- set stream_name_campaigns = 'campaigns' -%}
{%- set table_pattern_campaigns = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_registry ~  '_[^_]+_' ~ stream_name_campaigns ~ '$' -%}
{%- set relations_campaigns = datacraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_campaigns) -%}   
{%- if not relations_campaigns -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern_campaigns ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table_campaigns = '(' ~ dbt_utils.union_relations(relations_campaigns) ~ ')' -%}
{%- if not source_table_campaigns -%} 
    {{ exceptions.raise_compiler_error('No source_table_campaigns were found by pattern "' ~ table_pattern_campaigns ~ '"') }}
{%- endif -%}

{#- получаем список date_from:xxx[0], date_to:yyy[0] из union всех normalize таблиц -#}
  {% set min_max_date_dict = datacraft.get_min_max_date('normalize',sourcetype_name) %}                                                             
  {% if not min_max_date_dict %} 
      {{ exceptions.raise_compiler_error('No min_max_date_dict') }} 
  {% endif %}
  {% set date_from = min_max_date_dict.get('date_from')[0] %}
  {% if not date_from %} 
      {{ exceptions.raise_compiler_error('No date_from') }} 
  {% endif %}
  {% set date_to = min_max_date_dict.get('date_to')[0] %}
  {% if not date_to %} 
      {{ exceptions.raise_compiler_error('No date_to') }} 
  {% endif %}

WITH banners_statistics AS (
SELECT * FROM {{ source_table_banners_statistics }}
{%- if date_from and date_to %} 
WHERE toDate(__date) BETWEEN '{{date_from}}' AND '{{date_to}}'
{%- endif -%}
),

banners AS (
SELECT * FROM {{ source_table_banners }}
),

campaigns AS (
SELECT * FROM {{ source_table_campaigns }}
)

SELECT 
    toDate(banners_statistics.__date) AS __date,
    toLowCardinality('*') AS reportType,  
    toLowCardinality(splitByChar('_', banners_statistics.__table_name)[8]) AS accountName,
    toLowCardinality(banners_statistics.__table_name) AS __table_name,
    'MyTarget' AS adSourceDirty,
    --'' AS productName,
    campaigns.name AS adCampaignName,
    --'' AS adGroupName,
    banners.id AS adId,
    --'' AS adPhraseId,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_source=([^&]*)') AS utmSource,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_medium=([^&]*)') AS utmMedium,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_term=([^&]*)') AS utmTerm,
    extract(JSON_VALUE(replaceAll(banners.urls, '''', '"'), '$.primary.url'), 'utm_content=([^&]*)') AS utmContent,
    {{ datacraft.get_utmhash('__', fields=['utmContent', 'utmCampaign', 'adCampaignName']) }} AS utmHash,
    JSON_VALUE(replaceAll(banners.textblocks, '''', '"'), '$.title_25.text') AS adTitle1,
    --'' AS adTitle2,
    assumeNotNull(coalesce(nullif(JSON_VALUE(replaceAll(banners.textblocks, '''', '"'), '$.text_90.text'), ''),
    JSON_VALUE(replaceAll(banners.textblocks, '''', '"'), '$.text_220.text'), '')) AS adText,
    --'' AS adPhraseName,
    toFloat64(JSONExtractString(banners_statistics.base, 'spent'))* 1.2 AS adCost,
    toInt32(JSONExtractString(banners_statistics.base, 'shows')) AS impressions,
    toInt32(JSONExtractString(banners_statistics.base, 'clicks')) AS clicks,
    banners_statistics.__emitted_at AS __emitted_at,
    toLowCardinality('AdCostStat') AS __link 
FROM banners_statistics
JOIN banners ON banners_statistics.banner_id = banners.id 
JOIN campaigns ON banners.campaign_id = campaigns.id
{% if limit0 %}
LIMIT 0
{%- endif -%}

{%-endif -%}
{% endmacro %}