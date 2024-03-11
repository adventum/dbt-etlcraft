{%- macro join_ym_events(
    sourcetype_name,
    pipeline_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{%- set sourcetype_name = 'ym' -%}
{%- set pipeline_name = 'events' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+'  -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 

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
{#- assumeNotNull(coalesce(nullIf(trim(BOTH '\'' FROM arrayElement(ymsparsedParamsKey2, indexOf(ymsparsedParamsKey1, '\'mp_card_number\''))), 'null'), '')) as mpCardNumber, -#}
    extract(ymspurchaseCoupon, '\'([^\'\[\],]+)') AS promoCode,   
    'web' AS osName,
    ymsregionCity AS cityName,
 {#- trim(BOTH '\'' FROM arrayElement(ymsparsedParamsKey2, indexOf(ymsparsedParamsKey1, '\'city_code\''))) AS cityCode,  -#}
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
{#- assumeNotNull(coalesce(arraySum(ymspurchaseRevenue), 0)) AS amountSales,  -#}
    if(countSubstrings(ymsgoalsID, '199402504')>0,1,0) AS registrationCardSessions,
    if(countSubstrings(ymsgoalsID, '199402597')>0,1,0) AS linkingCardToPhoneNumberSessions, 
    if(countSubstrings(ymsgoalsID, '226410025')>0,1,0) AS registrationLendingPromotionsSessions, 
    if(countSubstrings(ymsgoalsID, '232977064')>0,1,0) AS registrationCashbackSessions, 
    if(countSubstrings(ymsgoalsID, '232977580')>0,1,0) AS couponActivationSessions, 
    if(countSubstrings(ymsgoalsID, '232977647')>0,1,0) AS participationInLotterySessions,
    toUInt32(ymspageViews) AS pageViews,
    __emitted_at
    {#-toLowCardinality({{ link_hash('VisitStat', metadata) }}) AS __link #}

FROM events


{% endmacro %}