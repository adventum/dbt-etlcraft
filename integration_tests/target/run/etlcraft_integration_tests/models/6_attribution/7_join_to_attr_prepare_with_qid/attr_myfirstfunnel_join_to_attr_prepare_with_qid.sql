
  
    
    
        
        insert into test.attr_myfirstfunnel_join_to_attr_prepare_with_qid__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash", "AppProfileMatchingHash", "__last_click_rank", "__first_click_rank", "adSourceDirty")
  -- depends_on: test.attr_myfirstfunnel_prepare_with_qid
-- depends_on: test.attr_myfirstfunnel_create_missed_steps






select 
    y.__period_number as __period_number, 
    y.__if_missed as __if_missed, 
    y.__priority as __priority, 
    y.__step as __step,
    x.*EXCEPT(adSourceDirty),



    CASE
    WHEN LENGTH (adSourceDirty) < 2 THEN 1
    WHEN match(adSourceDirty, 'Органическая установка') THEN 2
    WHEN __priority = 4 and not __if_missed = 1 THEN 3
    WHEN __priority = 3 and not __if_missed = 1 THEN 4
    WHEN __priority = 2 and not __if_missed = 1 THEN 5
    WHEN __priority = 1 and not __if_missed = 1 THEN 6
    
    ELSE 0
    END as __last_click_rank,

    CASE
    WHEN __priority = 3 and not __if_missed = 1 THEN 1
    WHEN __priority = 2 and not __if_missed = 1 THEN 2
    WHEN __priority = 1 and not __if_missed = 1 THEN 3
    
    ELSE 0
    END as __first_click_rank,



CASE

         WHEN  __if_missed and __priority = 1 
         THEN '[Без веб сессии]'
    

         WHEN  __if_missed and __priority = 2 
         THEN '[Без установки]'
    

         WHEN  __if_missed and __priority = 3 
         THEN '[Без апп сессии]'
    
         WHEN  __if_missed and __priority = 3 
         THEN '[Без апп сессии]'
    

         WHEN  __if_missed and __priority = 4 
         THEN ''
    

ELSE adSourceDirty
END as adSourceDirty

from test.attr_myfirstfunnel_prepare_with_qid AS x
join test.attr_myfirstfunnel_create_missed_steps AS y
    using (qid, __datetime, __link, __id)




  