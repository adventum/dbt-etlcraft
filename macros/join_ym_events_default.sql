{%- macro join_ym_events_default(
    sourcetype_name,
    pipeline_name,
    template_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

WITH events AS (
SELECT * FROM {{ ref('incremental_ym_events_default_yandex_metrika_stream') }}
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
FROM events


{% endmacro %}