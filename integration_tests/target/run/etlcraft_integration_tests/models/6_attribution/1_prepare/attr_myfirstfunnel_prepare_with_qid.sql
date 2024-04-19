
  
    
    
        
        insert into test.attr_myfirstfunnel_prepare_with_qid__dbt_backup ("y.qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "visitId", "clientId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "qid", "t2.appmetricaDeviceId", "t2.crmUserId", "t2.cityName", "t2.utmHash", "t2.__emitted_at", "t2.__table_name", "UtmHashRegistryHash", "AppProfileMatchingHash", "t2.UtmHashHash", "t2.AppMetricaDeviceHash", "t2.CrmUserHash")
  -- depends_on: test.full_events
-- depends_on: test.graph_qid




SELECT
    y.qid, x.*
FROM test.full_events AS x
LEFT JOIN test.graph_qid AS y
    USING (__datetime,__link, __id)





  