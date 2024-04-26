-- depends_on: test.incremental_appmetrica_events_default_deeplinks
-- depends_on: test.incremental_appmetrica_events_default_events
-- depends_on: test.incremental_appmetrica_events_default_install
-- depends_on: test.incremental_appmetrica_events_default_screen_view
-- depends_on: test.incremental_appmetrica_events_default_sessions_starts
WITH join_appmetrica_events_deeplinks AS (
SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_datetime) AS event_datetime,
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    --'' AS visitId, --
    --'' AS clientId, -- 
    '' AS promoCode, --
    os_name AS osName,
    city AS cityName,
    assumeNotNull(coalesce(lower(if(length(utmSource) > 0, concat(utmSource, ' / ', utmMedium), null)), publisher_name, '')) AS adSourceDirty,
    extract(deeplink_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(deeplink_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(deeplink_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(deeplink_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(deeplink_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    '' AS transactionId,
    greatest(coalesce(extract(utmCampaign, '__([a-zA-Z0-9]{8})'), ''), coalesce(extract(utmContent, '__([a-zA-Z0-9]{8})'), '')) AS utmHash,
    0 AS sessions, --
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    0 AS installApp,
    0 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppDeeplinkStat') AS __link
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_deeplinks' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("deeplink_url_parameters" as String) as "deeplink_url_parameters" ,
                    cast("event_datetime" as String) as "event_datetime" ,
                    cast("google_aid" as String) as "google_aid" ,
                    cast("ios_ifa" as String) as "ios_ifa" ,
                    cast("os_name" as String) as "os_name" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("publisher_name" as String) as "publisher_name" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_events_default_deeplinks

            
        )

        )
), union_events AS (
SELECT
    __emitted_at,
    splitByChar('_', __table_name)[6] AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    city AS cityName,
    event_name AS eventName,
    event_json AS eventJson,
    session_id AS sessionId,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    JSONExtractString(event_json, 'transaction_id') AS transactionId,
    appmetrica_device_id AS appmetricaDeviceId,
    os_name AS osName,
    profile_id AS crmUserId,
    JSONExtractString(event_json, 'coupon') AS promoCode,    
    toDate(__date) AS __date, 
    toDateTime(event_datetime) AS event_datetime, 
    0 AS screen_view
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_events' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("app_version_name" as String) as "app_version_name" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("event_datetime" as String) as "event_datetime" ,
                    cast("event_json" as String) as "event_json" ,
                    cast("event_name" as String) as "event_name" ,
                    cast("google_aid" as String) as "google_aid" ,
                    cast("installation_id" as String) as "installation_id" ,
                    cast("ios_ifa" as String) as "ios_ifa" ,
                    cast("os_name" as String) as "os_name" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("session_id" as String) as "session_id" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_events_default_events

            
        )

        )
)
, join_appmetrica_events_prepare AS (
SELECT 
    __date,
    toLowCardinality(__table_name) AS __table_name,
    event_datetime,
    toLowCardinality(accountName) AS accountName,
    appmetricaDeviceId,
    mobileAdsId,
    crmUserId,   
    --'' AS visitId,
    --'' AS clientId,
    promoCode,
    osName,
    cityName,
    '' AS adSourceDirty,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    transactionId,
    '' AS UtmHash,
    0 AS sessions,
    eventName = 'add_to_cart' AS addToCartSessions,
    eventName = 'view_cart' AS cartViewSessions,
    eventName = 'begin_checkout' AS checkoutSessions,
    eventName = 'purchase' AS webSalesSessions,
    eventName = 'purchase' AS sales,    
    assumeNotNull(coalesce(if(eventName = 'purchase', toFloat64(nullif(JSONExtractString(JSONExtractString(JSONExtractString(eventJson, 'value'), 'fiat'), 'value'), '')), 0), 0)) AS amountSales,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'BindVirtualCard' AND  JSONExtractString(eventJson, 'item_name') = 'Auth' AS registrationCardSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'IntroRegistrationButtonClick' AND (JSONExtractString(eventJson, 'item_name') = 'AdventCalendar' or JSONExtractString(eventJson, 'item_name') = 'ScratchCards') as registrationButtonClick,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'BindPlasticCard' AND  JSONExtractString(eventJson, 'item_name') = 'Auth' AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CashbackButtonRegistration' AND  JSONExtractString(eventJson, 'item_name') = 'Cashback' AS registrationCashbackSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'ButtonActivate' AS instantDiscountActivationSessions,
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponListActivateCoupon' AND  JSONExtractString(eventJson, 'item_name') = 'Coupons') OR
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponDetailActivate' AND  JSONExtractString(eventJson, 'item_name') = 'Coupons') OR 
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponListActivateCoupon' AND  JSONExtractString(eventJson, 'item_name') = 'Club') AS couponActivationSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'TakePartButton' AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    0 AS installApp,
    0 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppEventStat') AS __link,
    JSONExtractString(eventJson, 'item_category') AS __itemCategory, 
    JSONExtractString(eventJson, 'item_name') AS __itemName,
    row_number() over() AS __rn,
    eventName AS __eventName, 
    sessionId AS __sessionId
FROM union_events
WHERE addToCartSessions > 0 OR cartViewSessions > 0 OR checkoutSessions > 0 OR registrationButtonClick > 0
  OR webSalesSessions > 0  OR sales > 0 OR amountSales > 0 
  OR registrationCardSessions > 0 OR linkingCardToPhoneNumberSessions > 0 
  OR registrationCashbackSessions > 0 OR instantDiscountActivationSessions > 0 
  OR couponActivationSessions > 0 OR participationInLotterySessions > 0 or screenView > 0
ORDER BY __date
)
, min_event AS (
SELECT MIN(__rn) AS __rn 
FROM join_appmetrica_events_prepare
GROUP BY appmetricaDeviceId, __sessionId, __eventName, __itemCategory, __itemName
), join_appmetrica_events_events AS (
SELECT * EXCEPT(__itemCategory, __itemName, __rn, __eventName, __sessionId)
FROM join_appmetrica_events_prepare
WHERE __rn IN (SELECT __rn FROM min_event) AND  
    (addToCartSessions > 0 OR cartViewSessions > 0 OR checkoutSessions > 0 
    OR webSalesSessions > 0  OR sales > 0 OR amountSales > 0 
    OR registrationCardSessions > 0 OR linkingCardToPhoneNumberSessions > 0 
    OR registrationCashbackSessions > 0 OR instantDiscountActivationSessions > 0 OR registrationButtonClick > 0
    OR couponActivationSessions > 0 OR participationInLotterySessions > 0)
), join_appmetrica_events_install AS (
SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(install_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    --'' AS visitId,
    --'' AS clientId,
    '' AS promoCode,
    os_name AS osName,
    city AS cityName,
    if(match(click_url_parameters, 'organic'), 'Органическая установка', assumeNotNull(coalesce(lower(if(length(utmSource) > 0, concat(utmSource, ' / ', utmMedium), null)), publisher_name, ''))) AS adSourceDirty,
    extract(click_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(click_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(click_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(click_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(click_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    '' AS transactionId,
    greatest(coalesce(extract(utmContent, '__([a-zA-Z0-9]{8})'), ''), coalesce(extract(utmCampaign, '__([a-zA-Z0-9]{8})'), '')) AS utmHash,
    0 AS sessions,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    is_reinstallation = 'false' AS installApp,
    1 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppInstallStat') AS __link
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_install' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("click_datetime" as String) as "click_datetime" ,
                    cast("click_url_parameters" as String) as "click_url_parameters" ,
                    cast("google_aid" as String) as "google_aid" ,
                    cast("install_datetime" as String) as "install_datetime" ,
                    cast("ios_ifa" as String) as "ios_ifa" ,
                    cast("is_reinstallation" as String) as "is_reinstallation" ,
                    cast("os_name" as String) as "os_name" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("publisher_name" as String) as "publisher_name" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_events_default_install

            
        )

        )
), join_appmetrica_events_screen_view AS (
SELECT
    toDateTime(date_add(hour, 23, date_add(minute, 59, toDateTime(__date)))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_datetime) AS event_datetime, 
    accountName,
    appmetricaDeviceId,
    mobileAdsId,
    crmUserId, 
    --'' AS visitId,
    --'' AS clientId,
    '' AS promoCode,
    osName,
    cityName,
    '' AS adSourceDirty,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    '' AS transactionId,
    '' AS utmHash,
    0 AS sessions,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,    
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    screen_view AS screenView,
    0 AS installApp,
    0 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppEventStat') AS __link 
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_screen_view' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("event_datetime" as DateTime) as "event_datetime" ,
                    cast("mobileAdsId" as String) as "mobileAdsId" ,
                    cast("accountName" as String) as "accountName" ,
                    cast("appmetricaDeviceId" as String) as "appmetricaDeviceId" ,
                    cast("cityName" as String) as "cityName" ,
                    cast("osName" as String) as "osName" ,
                    cast("crmUserId" as String) as "crmUserId" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("session_id" as String) as "session_id" ,
                    cast("screen_view" as UInt64) as "screen_view" 

            from test.incremental_appmetrica_events_default_screen_view

            
        )

        )
), join_appmetrica_events_sessions_starts AS (
SELECT
    toDateTime(date_add(minute, 1, toDateTime(__date))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(session_start_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    profile_id AS crmUserId,
    --'' AS visitId,
    --'' AS clientId,
    '' AS promoCode,
    os_name AS osName,
    city AS cityName,
    '' AS adSourceDirty,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    '' AS transactionId,
    '' AS UtmHash,
    1 AS sessions,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    0 AS installApp,
    0 AS installs,
    CONCAT(installation_id, appmetrica_device_id) AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppSessionStat') AS __link 
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_sessions_starts' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("google_aid" as String) as "google_aid" ,
                    cast("installation_id" as String) as "installation_id" ,
                    cast("ios_ifa" as String) as "ios_ifa" ,
                    cast("os_name" as String) as "os_name" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("session_start_datetime" as String) as "session_start_datetime" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_events_default_sessions_starts

            
        )

        )
)SELECT * 
FROM join_appmetrica_events_deeplinks
UNION ALL
SELECT * 
FROM join_appmetrica_events_events
UNION ALL
SELECT * 
FROM join_appmetrica_events_install
UNION ALL
SELECT * 
FROM join_appmetrica_events_screen_view
UNION ALL
SELECT * 
FROM join_appmetrica_events_sessions_starts




