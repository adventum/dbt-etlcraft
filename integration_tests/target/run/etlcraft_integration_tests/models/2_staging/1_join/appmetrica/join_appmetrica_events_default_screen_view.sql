
        
  
    
    
        
        insert into test.join_appmetrica_events_default_screen_view__dbt_tmp ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "transactionId", "promoCode", "osName", "cityName", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "screenView", "__emitted_at")
  SELECT
    toDateTime(date_add(hour, 23, date_add(minute, 59, toDateTime(__date)))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_datetime) AS event_datetime, 
    accountName,
    appmetricaDeviceId,
    mobileAdsId,
    crmUserId,    
    '' AS transactionId,
    '' AS promoCode,
    osName,
    cityName,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,    
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    screen_view AS screenView,
    __emitted_at
FROM test.incremental_appmetrica_events_default_screen_view





  
    