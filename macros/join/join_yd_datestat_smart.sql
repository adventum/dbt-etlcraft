{%- macro join_yd_datestat_smart(
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
    on_schema_change='append_new_columns'
) }}

{%- if execute -%}
{%- set sourcetype_name = 'yd' -%}
{%- set pipeline_name_datestat = 'datestat' -%} 
{%- set pipeline_name_registry = 'registry' -%}

{%- set stream_name_custom_report = 'custom_report' -%}
{%- set table_pattern_custom_report = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_datestat ~  '_[^_]+_' ~ stream_name_custom_report ~ '$' -%}
{%- set relations_custom_report = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_custom_report) -%}   
{%- if not relations_custom_report -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern_custom_report ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table_custom_report = '(' ~ dbt_utils.union_relations(relations_custom_report) ~ ')' -%} 
{%- if not source_table_custom_report -%} 
    {{ exceptions.raise_compiler_error('No source_table_custom_report were found by pattern "' ~ table_pattern_custom_report ~ '"') }}
{%- endif -%}

{%- set stream_name_custom_report_smart = 'custom_report_smart' -%}
{%- set table_pattern_custom_report_smart = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_datestat ~  '_[^_]+_' ~ stream_name_custom_report_smart ~ '$' -%}
{%- set relations_custom_report_smart = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_custom_report_smart) -%}   
{%- if not relations_custom_report_smart -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern_custom_report_smart ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table_custom_report_smart = '(' ~ dbt_utils.union_relations(relations_custom_report_smart) ~ ')' -%}
{%- if not source_table_custom_report_smart -%} 
    {{ exceptions.raise_compiler_error('No source_table_custom_report_smart were found by pattern "' ~ table_pattern_custom_report_smart ~ '"') }}
{%- endif -%}

{%- set stream_name_ads = 'ads' -%}
{%- set table_pattern_ads = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_registry ~  '_[^_]+_' ~ stream_name_ads ~ '$' -%}
{%- set relations_ads = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_ads) -%}   
{%- if not relations_ads -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern_ads ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table_ads = '(' ~ dbt_utils.union_relations(relations_ads) ~ ')' -%}
{%- if not source_table_ads -%} 
    {{ exceptions.raise_compiler_error('No source_table_ads were found by pattern "' ~ table_pattern_ads ~ '"') }}
{%- endif -%}

{#- получаем список date_from:xxx[0], date_to:yyy[0] из union всех normalize таблиц -#}
  {% set min_max_date_dict = etlcraft.get_min_max_date('normalize',sourcetype_name) %}                                                             
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

with custom_report_filter as (

    select * from {{ source_table_custom_report }}

),

custom_report_smart as (

    select * from {{ source_table_custom_report_smart }}
    where CampaignId not in (select CampaignId from custom_report_filter)

),

custom_report as (

    select * from custom_report_filter
    union all
    select * from custom_report_smart

),

ads as (

    select * from {{ source_table_ads }}

),

prepare as (
select
        toDate(custom_report.Date) as __date,
        custom_report.__table_name as __table_name,
        toDate(custom_report.Date) as adCostDate,
        toLowCardinality('*') as reportType,
        toLowCardinality(splitByChar('_', custom_report.__table_name)[5]) as accountName,
        'Yandex Direct Ads' as adSourceDirty,
        trim(normalizeUTF8NFKC(custom_report.CampaignName)) as adCampaignName,
        ads.Status as adCampaignStatus,
        custom_report.AdGroupName as adGroupName,
        custom_report.AdId as adId,
        custom_report.CriteriaId as adPhraseId,
        trim(decodeURLComponent(normalizeUTF8NFKC(extract(landingPageName, 'utm_source=([^&]*)')))) as utmSource,
        trim(decodeURLComponent(normalizeUTF8NFKC(extract(landingPageName, 'utm_medium=([^&]*)')))) as utmMedium,
        trim(replaceRegexpAll(decodeURLComponent(normalizeUTF8NFKC(extract(landingPageName, 'utm_campaign=([^&]*)'))), '\|{[a-zA-Z0-9_]*}', '')) as utmCampaign,
        trim(extract(landingPageName, 'utm_term=([^&]*)')) as utmTerm,
        trim(extract(landingPageName, 'utm_content=([^&]*)')) as utmContent,
        JSONExtractString(coalesce(ads.TextAd, ads.DynamicTextAd, ads.MobileAppAd, ads.TextImageAd, ads.MobileAppImageAd,
                                   ads.TextAdBuilderAd, ads.MobileAppAdBuilderAd, ads.MobileAppCpcVideoAdBuilderAd, ads.CpmBannerAdBuilderAd,
                                   ads.CpcVideoAdBuilderAd, ads.CpmVideoAdBuilderAd, ads.SmartAdBuilderAd), 'Title') as adTitle1,
        JSONExtractString(coalesce(ads.TextAd, ads.DynamicTextAd, ads.MobileAppAd, ads.TextImageAd, ads.MobileAppImageAd,
                                   ads.TextAdBuilderAd, ads.MobileAppAdBuilderAd, ads.MobileAppCpcVideoAdBuilderAd, ads.CpmBannerAdBuilderAd,
                                   ads.CpcVideoAdBuilderAd, ads.CpmVideoAdBuilderAd, ads.SmartAdBuilderAd), 'Title2') as adTitle2,
        JSONExtractString(coalesce(ads.TextAd, ads.DynamicTextAd, ads.MobileAppAd, ads.TextImageAd, ads.MobileAppImageAd,
                                   ads.TextAdBuilderAd, ads.MobileAppAdBuilderAd, ads.MobileAppCpcVideoAdBuilderAd, ads.CpmBannerAdBuilderAd,
                                   ads.CpcVideoAdBuilderAd, ads.CpmVideoAdBuilderAd, ads.SmartAdBuilderAd), 'Text') as adText,
        trim(custom_report.Criteria) as adPhraseName,
        toFloat64(custom_report.Cost) / 1000000 as adCost,
        toInt32(custom_report.Impressions) as impressions,
        toInt32(custom_report.Clicks) as clicks,
        0 as fullReads, 
        0 as clickouts,
        __normalized_at as load_date,
        JSONExtractString(coalesce(ads.TextAd, ads.DynamicTextAd, ads.MobileAppAd, ads.TextImageAd, ads.MobileAppImageAd,
                           ads.TextAdBuilderAd, ads.MobileAppAdBuilderAd, ads.MobileAppCpcVideoAdBuilderAd, ads.CpmBannerAdBuilderAd,
                           ads.CpcVideoAdBuilderAd, ads.CpmVideoAdBuilderAd, ads.SmartAdBuilderAd), 'Href') as landingPageName

    from custom_report
    left join ads on custom_report.AdId = ads.Id)
    
select * except(landingPageName) from prepare

{%-endif -%}
{% endmacro %}