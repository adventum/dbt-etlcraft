-- depends_on: test.incremental_ym_events_default_yandex_metrika_stream
                                                             
  
  
  
  
  

WITH events AS (
SELECT * FROM (
    

        (
            select
                cast('test.incremental_ym_events_default_yandex_metrika_stream' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("ymsclientID" as String) as "ymsclientID" ,
                    cast("ymsdateTime" as String) as "ymsdateTime" ,
                    cast("ymsgoalsID" as String) as "ymsgoalsID" ,
                    cast("ymsgoalsOrder" as String) as "ymsgoalsOrder" ,
                    cast("ymslastAdvEngine" as String) as "ymslastAdvEngine" ,
                    cast("ymslastReferalSource" as String) as "ymslastReferalSource" ,
                    cast("ymslastSearchEngine" as String) as "ymslastSearchEngine" ,
                    cast("ymslastTrafficSource" as String) as "ymslastTrafficSource" ,
                    cast("ymspageViews" as String) as "ymspageViews" ,
                    cast("ymsparsedParamsKey1" as String) as "ymsparsedParamsKey1" ,
                    cast("ymsparsedParamsKey2" as String) as "ymsparsedParamsKey2" ,
                    cast("ymspurchaseCoupon" as String) as "ymspurchaseCoupon" ,
                    cast("ymspurchaseID" as String) as "ymspurchaseID" ,
                    cast("ymspurchaseRevenue" as String) as "ymspurchaseRevenue" ,
                    cast("ymsregionCity" as String) as "ymsregionCity" ,
                    cast("ymsUTMCampaign" as String) as "ymsUTMCampaign" ,
                    cast("ymsUTMContent" as String) as "ymsUTMContent" ,
                    cast("ymsUTMMedium" as String) as "ymsUTMMedium" ,
                    cast("ymsUTMSource" as String) as "ymsUTMSource" ,
                    cast("ymsUTMTerm" as String) as "ymsUTMTerm" ,
                    cast("ymsvisitID" as String) as "ymsvisitID" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_ym_events_default_yandex_metrika_stream

            
        )

        ) 
WHERE toDate(__date) BETWEEN '2024-02-16' AND '2024-02-29')

SELECT  
    __date, 
    __table_name,  
    ymsvisitID As visitId,
    ymsclientID AS clientId,
    extract(ymspurchaseCoupon, '\'([^\'\[\],]+)') AS promoCode,   
    'web' AS osName,
    ymsregionCity AS cityName,
    lower(ymsregionCity) AS cityCode,
    assumeNotNull(coalesce(lower(if(length(ymsUTMSource) > 0, concat(ymsUTMSource, ' / ', ymsUTMMedium), null)), 
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


