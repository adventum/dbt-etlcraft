


WITH visits AS (
SELECT * FROM test.incremental_ym_default_yandex_metrika_stream 
WHERE toDate(__datetime) BETWEEN '2024-02-07' AND '2024-02-19')

SELECT  
    __datetime, 
    __table_name,  
    ymsvisitID As visitId,
    ymsclientID AS clientId,extract(ymspurchaseCoupon, '\'([^\'\[\],]+)') AS promoCode,   
    'web' AS osName,
    ymsregionCity AS cityName,assumeNotNull(coalesce(lower(if(length(ymsUTMSource) > 0, concat(ymsUTMSource, ' / ', ymsUTMMedium), null)), 
    multiIf(ymslastTrafficSource = 'ad', lower(if(length(ymslastAdvEngine) > 0, concat(ymslastAdvEngine, ' / ', ymslastTrafficSource), null)),  
    ymslastTrafficSource = 'organic', lower(if(length(ymslastSearchEngine) > 0, concat(ymslastSearchEngine, ' / ', ymslastTrafficSource), null)),  
    lower(if(length(ymslastReferalSource) > 0, concat(ymslastReferalSource, ' / ', ymslastTrafficSource), null))), '')) AS adSourceDirty, 
    ymsUTMSource AS utmSource,
    ymsUTMMedium AS utmMedium,
    ymsUTMCampaign AS utmCampaign,
    ymsUTMTerm AS utmTerm,
    ymsUTMContent AS utmContent,
    ymspurchaseID AS transactionId,
    greatest(coalesce(extract(ymsUTMCampaign, '__([a-zA-Z0-9]{8})'), ''), coalesce(extract(ymsUTMContent, '__([a-zA-Z0-9]{8})'), '')) AS utmHash,
    1 AS sessions,
    if(countSubstrings(ymsgoalsID, '131126368')>0,1,0) AS addToCartSessions, 
    if(countSubstrings(ymsgoalsID, '229829884')>0,1,0) AS cartViewSessions, 
    if(countSubstrings(ymsgoalsID, '131126557')>0,1,0) AS checkoutSessions, 
    if(countSubstrings(ymsgoalsID, '131127241')>0,1,0) AS webSalesSessions, 
    countSubstrings(ymsgoalsID, '131127241') AS sales,if(countSubstrings(ymsgoalsID, '199402504')>0,1,0) AS registrationCardSessions,
    if(countSubstrings(ymsgoalsID, '199402597')>0,1,0) AS linkingCardToPhoneNumberSessions, 
    if(countSubstrings(ymsgoalsID, '226410025')>0,1,0) AS registrationLendingPromotionsSessions, 
    if(countSubstrings(ymsgoalsID, '232977064')>0,1,0) AS registrationCashbackSessions, 
    if(countSubstrings(ymsgoalsID, '232977580')>0,1,0) AS couponActivationSessions, 
    if(countSubstrings(ymsgoalsID, '232977647')>0,1,0) AS participationInLotterySessions,
    toUInt32(ymspageViews) AS pageViews,
    __emitted_at AS load_date
FROM visits







