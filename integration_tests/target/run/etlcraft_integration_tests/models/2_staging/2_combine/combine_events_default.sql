

  create view test.combine_events_default__dbt_tmp 
  
  as (
    -- depends_on: test.join_appmetrica_events_default_events
-- depends_on: test.join_appmetrica_events_default_screen_view


SELECT *
FROM 

    

        (
            select
                cast('test.join_appmetrica_events_default_events' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("event_datetime" as DateTime) as "event_datetime" ,
                    cast("accountName" as String) as "accountName" ,
                    cast("appmetricaDeviceId" as String) as "appmetricaDeviceId" ,
                    cast("mobileAdsId" as String) as "mobileAdsId" ,
                    cast("crmUserId" as String) as "crmUserId" ,
                    cast("transactionId" as String) as "transactionId" ,
                    cast("promoCode" as String) as "promoCode" ,
                    cast("osName" as String) as "osName" ,
                    cast("cityName" as String) as "cityName" ,
                    cast("addToCartSessions" as UInt8) as "addToCartSessions" ,
                    cast("cartViewSessions" as UInt8) as "cartViewSessions" ,
                    cast("checkoutSessions" as UInt8) as "checkoutSessions" ,
                    cast("webSalesSessions" as UInt8) as "webSalesSessions" ,
                    cast("sales" as UInt8) as "sales" ,
                    cast("amountSales" as Float64) as "amountSales" ,
                    cast("registrationCardSessions" as UInt8) as "registrationCardSessions" ,
                    cast("registrationButtonClick" as UInt8) as "registrationButtonClick" ,
                    cast("linkingCardToPhoneNumberSessions" as UInt8) as "linkingCardToPhoneNumberSessions" ,
                    cast("registrationCashbackSessions" as UInt8) as "registrationCashbackSessions" ,
                    cast("instantDiscountActivationSessions" as UInt8) as "instantDiscountActivationSessions" ,
                    cast("couponActivationSessions" as UInt8) as "couponActivationSessions" ,
                    cast("participationInLotterySessions" as UInt8) as "participationInLotterySessions" ,
                    cast("screenView" as UInt8) as "screenView" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" 

            from test.join_appmetrica_events_default_events

            
        )

        union all
        

        (
            select
                cast('test.join_appmetrica_events_default_screen_view' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("event_datetime" as DateTime) as "event_datetime" ,
                    cast("accountName" as String) as "accountName" ,
                    cast("appmetricaDeviceId" as String) as "appmetricaDeviceId" ,
                    cast("mobileAdsId" as String) as "mobileAdsId" ,
                    cast("crmUserId" as String) as "crmUserId" ,
                    cast("transactionId" as String) as "transactionId" ,
                    cast("promoCode" as String) as "promoCode" ,
                    cast("osName" as String) as "osName" ,
                    cast("cityName" as String) as "cityName" ,
                    cast("addToCartSessions" as UInt8) as "addToCartSessions" ,
                    cast("cartViewSessions" as UInt8) as "cartViewSessions" ,
                    cast("checkoutSessions" as UInt8) as "checkoutSessions" ,
                    cast("webSalesSessions" as UInt8) as "webSalesSessions" ,
                    cast("sales" as UInt8) as "sales" ,
                    cast("amountSales" as Float64) as "amountSales" ,
                    cast("registrationCardSessions" as UInt8) as "registrationCardSessions" ,
                    cast("registrationButtonClick" as UInt8) as "registrationButtonClick" ,
                    cast("linkingCardToPhoneNumberSessions" as UInt8) as "linkingCardToPhoneNumberSessions" ,
                    cast("registrationCashbackSessions" as UInt8) as "registrationCashbackSessions" ,
                    cast("instantDiscountActivationSessions" as UInt8) as "instantDiscountActivationSessions" ,
                    cast("couponActivationSessions" as UInt8) as "couponActivationSessions" ,
                    cast("participationInLotterySessions" as UInt8) as "participationInLotterySessions" ,
                    cast("screenView" as UInt8) as "screenView" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" 

            from test.join_appmetrica_events_default_screen_view

            
        )

        



  )