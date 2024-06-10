{%- macro join_ym_events(
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
{%- if execute -%}
{%- set sourcetype_name = 'ym' -%}
{%- set pipeline_name = 'events' -%}
{%- set stream_name = 'yandex_metrika_stream' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~ '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}  
{%- if not relations -%} 
    {{ exceptions.raise_compiler_error('No relations') }}
{%- endif -%}
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 
{%- if not source_table -%} 
    {{ exceptions.raise_compiler_error('No source_table') }}
{%- endif -%}

{#- получаем список date_from:xxx[0], date_to:yyy[0] из union всех normalize ??? таблиц -#}
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
  
WITH events AS (
SELECT * FROM {{ source_table }}
{%- if date_from and  date_to %} 
WHERE toDate(__date) BETWEEN '{{date_from}}' AND '{{date_to}}'
{%- endif -%}
)

SELECT  
    __date, 
    __table_name,  
    ymsvisitID As visitId,
    ymsclientID AS clientId,
    extract(ymspurchaseCoupon, '\'([^\'\[\],]+)') AS promoCode,   
    'web' AS osName,
    ymsregionCity AS cityName,
    lower(ymsregionCity) AS cityCode,
    assumeNotNull(coalesce({{ etlcraft.get_adsourcedirty('ymsUTMSource', 'ymsUTMMedium') }}, 
    multiIf(ymslastTrafficSource = 'ad', {{ etlcraft.get_adsourcedirty('ymslastAdvEngine', 'ymslastTrafficSource') }},  
    ymslastTrafficSource = 'organic', {{ etlcraft.get_adsourcedirty('ymslastSearchEngine', 'ymslastTrafficSource') }},  
    {{ etlcraft.get_adsourcedirty('ymslastReferalSource', 'ymslastTrafficSource') }}), '')) AS adSourceDirty, 
    ymsUTMSource AS utmSource,
    ymsUTMMedium AS utmMedium,
    ymsUTMCampaign AS utmCampaign,
    ymsUTMTerm AS utmTerm,
    ymsUTMContent AS utmContent,
    ymspurchaseID AS transactionId,
    {{ etlcraft.get_utmhash('__', ['ymsUTMCampaign', 'ymsUTMContent']) }} AS utmHash,
    1 AS sessions,
    if(countSubstrings(ymsgoalsID, '131126368')>0,1,0) AS addToCartSessions, 
    if(countSubstrings(ymsgoalsID, '229829884')>0,1,0) AS cartViewSessions, 
    if(countSubstrings(ymsgoalsID, '131126557')>0,1,0) AS checkoutSessions, 
    if(countSubstrings(ymsgoalsID, '131127241')>0,1,0) AS webSalesSessions, 
    countSubstrings(ymsgoalsID, '131127241') AS sales, 
    --0.0 AS amountSales,
    if(countSubstrings(ymsgoalsID, '199402504')>0,1,0) AS registrationCardSessions,
    if(countSubstrings(ymsgoalsID, '199402597')>0,1,0) AS linkingCardToPhoneNumberSessions, 
    if(countSubstrings(ymsgoalsID, '226410025')>0,1,0) AS registrationLendingPromotionsSessions, 
    if(countSubstrings(ymsgoalsID, '232977064')>0,1,0) AS registrationCashbackSessions, 
    if(countSubstrings(ymsgoalsID, '232977580')>0,1,0) AS couponActivationSessions, 
    if(countSubstrings(ymsgoalsID, '232977647')>0,1,0) AS participationInLotterySessions,
    toUInt32(ymspageViews) AS pageViews,
    __emitted_at,
    toLowCardinality('VisitStat') AS __link 

FROM events

{%- endif -%}
{% endmacro %}