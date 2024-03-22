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




