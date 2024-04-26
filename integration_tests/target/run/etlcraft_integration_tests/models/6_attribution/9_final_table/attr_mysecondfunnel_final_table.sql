
  
    
    
        
        insert into test.attr_mysecondfunnel_final_table__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "t2.utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "t2.__emitted_at", "t2.__table_name", "UtmHashRegistryHash", "t2.UtmHashHash", "t2.appmetricaDeviceId", "t2.crmUserId", "t2.cityName", "AppProfileMatchingHash", "t2.AppMetricaDeviceHash", "t2.CrmUserHash", "__last_click_rank", "adSourceDirty", "__mysecondfunnel_last_click_utmSource", "__mysecondfunnel_last_click_utmMedium", "__mysecondfunnel_last_click_utmCampaign", "__mysecondfunnel_last_click_utmTerm", "__mysecondfunnel_last_click_utmContent", "__mysecondfunnel_last_click_adSourceDirty")
  -- depends_on: test.attr_mysecondfunnel_model




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_mysecondfunnel_join_to_attr_prepare_with_qid
        join  test.attr_mysecondfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out



  