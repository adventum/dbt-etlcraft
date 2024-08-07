
  
    
    
        
        insert into test.attr_myfirstfunnel_final_table__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "touch_type", "touch_time", "install_time", "event_time", "event_name", "event_source", "partner", "media_source", "campaign", "site_id", "ad", "country_code", "city", "appsflyer_id", "custom_uid", "platform", "is_retargeting", "is_primary_attribution", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash", "AppProfileMatchingHash", "__last_click_rank", "__first_click_rank", "adSourceDirty", "__myfirstfunnel_last_click_utmSource", "__myfirstfunnel_last_click_utmMedium", "__myfirstfunnel_last_click_utmCampaign", "__myfirstfunnel_last_click_utmTerm", "__myfirstfunnel_last_click_utmContent", "__myfirstfunnel_last_click_adSourceDirty", "__myfirstfunnel_first_click_utmSource", "__myfirstfunnel_first_click_utmMedium", "__myfirstfunnel_first_click_utmCampaign", "__myfirstfunnel_first_click_utmTerm", "__myfirstfunnel_first_click_utmContent", "__myfirstfunnel_first_click_adSourceDirty")
  -- depends_on: test.attr_myfirstfunnel_model
-- depends_on: test.attr_myfirstfunnel_join_to_attr_prepare_with_qid




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_myfirstfunnel_join_to_attr_prepare_with_qid
        join  test.attr_myfirstfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out 




  