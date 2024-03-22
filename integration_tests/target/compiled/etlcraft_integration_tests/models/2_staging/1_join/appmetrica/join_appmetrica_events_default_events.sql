WITH union_events AS (
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
FROM test.incremental_appmetrica_events_default_events
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
    transactionId,
    promoCode,
    osName,
    cityName,
    eventName = 'add_to_cart' AS addToCartSessions,
    eventName = 'view_cart' AS cartViewSessions,
    eventName = 'begin_checkout' AS checkoutSessions,
    eventName = 'purchase' AS webSalesSessions,
    eventName = 'purchase' AS sales,    
    assumeNotNull(coalesce(if(eventName = 'purchase', toFloat64(nullif(JSONExtractString(JSONExtractString(JSONExtractString(eventJson, 'value'), 'fiat'), 'value'), '')), 0), 0)) AS amountSales,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'BindVirtualCard' AND  JSONExtractString(eventJson, 'item_name') = 'Auth' AS registrationCardSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'IntroRegistrationButtonClick' AND (JSONExtractString(eventJson, 'item_name') = 'AdventCalendar' or JSONExtractString(eventJson, 'item_name') = 'ScratchCards') as registrationButtonClick,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'BindPlasticCard' AND  JSONExtractString(eventJson, 'item_name') = 'Auth' AS linkingCardToPhoneNumberSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CashbackButtonRegistration' AND  JSONExtractString(eventJson, 'item_name') = 'Cashback' AS registrationCashbackSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'ButtonActivate' AS instantDiscountActivationSessions,
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponListActivateCoupon' AND  JSONExtractString(eventJson, 'item_name') = 'Coupons') OR
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponDetailActivate' AND  JSONExtractString(eventJson, 'item_name') = 'Coupons') OR 
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponListActivateCoupon' AND  JSONExtractString(eventJson, 'item_name') = 'Club') AS couponActivationSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'TakePartButton' AS participationInLotterySessions,
    0 AS screenView,
    __emitted_at,
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
)

SELECT * EXCEPT(__itemCategory, __itemName, __rn, __eventName, __sessionId)
FROM join_appmetrica_events_prepare
WHERE __rn IN (SELECT __rn FROM min_event) AND  
    (addToCartSessions > 0 OR cartViewSessions > 0 OR checkoutSessions > 0 
    OR webSalesSessions > 0  OR sales > 0 OR amountSales > 0 
    OR registrationCardSessions > 0 OR linkingCardToPhoneNumberSessions > 0 
    OR registrationCashbackSessions > 0 OR instantDiscountActivationSessions > 0 OR registrationButtonClick > 0
    OR couponActivationSessions > 0 OR participationInLotterySessions > 0)






