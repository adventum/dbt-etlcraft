
  
    
    
        
        insert into test.attr_mysecondfunnel_final_table__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "qid", "None", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "visitId", "clientId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "YmClientHash", "__id", "__datetime", "__last_click_rank", "adSourceDirty", "__mysecondfunnel_last_click_utmSource", "__mysecondfunnel_last_click_utmMedium", "__mysecondfunnel_last_click_utmCampaign", "__mysecondfunnel_last_click_utmTerm", "__mysecondfunnel_last_click_utmContent", "__mysecondfunnel_last_click_adSourceDirty")
  -- depends_on: test.attr_mysecondfunnel_model




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_mysecondfunnel_join_to_attr_prepare_with_qid
        join  test.attr_mysecondfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out



  