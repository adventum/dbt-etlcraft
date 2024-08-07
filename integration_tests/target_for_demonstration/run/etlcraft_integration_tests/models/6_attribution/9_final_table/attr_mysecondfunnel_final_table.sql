
  
    
    
        
        insert into test.attr_mysecondfunnel_final_table__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "touch_type", "touch_time", "install_time", "event_time", "event_name", "event_source", "partner", "media_source", "campaign", "site_id", "ad", "country_code", "city", "appsflyer_id", "custom_uid", "platform", "is_retargeting", "is_primary_attribution", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash", "AppProfileMatchingHash", "__last_click_rank", "adSourceDirty", "__mysecondfunnel_last_click_utmSource", "__mysecondfunnel_last_click_utmMedium", "__mysecondfunnel_last_click_utmCampaign", "__mysecondfunnel_last_click_utmTerm", "__mysecondfunnel_last_click_utmContent", "__mysecondfunnel_last_click_adSourceDirty")
  -- depends_on: test.attr_mysecondfunnel_model
-- depends_on: test.attr_mysecondfunnel_join_to_attr_prepare_with_qid




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_mysecondfunnel_join_to_attr_prepare_with_qid
        join  test.attr_mysecondfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out 




  