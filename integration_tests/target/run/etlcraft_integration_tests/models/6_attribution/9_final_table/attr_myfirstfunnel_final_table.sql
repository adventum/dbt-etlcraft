
  
    
    
        
        insert into test.attr_myfirstfunnel_final_table__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "y.qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "visitId", "clientId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "qid", "t2.appmetricaDeviceId", "t2.crmUserId", "t2.cityName", "t2.utmHash", "t2.__emitted_at", "t2.__table_name", "UtmHashRegistryHash", "AppProfileMatchingHash", "t2.UtmHashHash", "t2.AppMetricaDeviceHash", "t2.CrmUserHash", "__last_click_rank", "__first_click_rank", "adSourceDirty", "__myfirstfunnel_last_click_utmSource", "__myfirstfunnel_last_click_utmMedium", "__myfirstfunnel_last_click_utmCampaign", "__myfirstfunnel_last_click_utmTerm", "__myfirstfunnel_last_click_utmContent", "__myfirstfunnel_last_click_adSourceDirty", "__myfirstfunnel_first_click_utmSource", "__myfirstfunnel_first_click_utmMedium", "__myfirstfunnel_first_click_utmCampaign", "__myfirstfunnel_first_click_utmTerm", "__myfirstfunnel_first_click_utmContent", "__myfirstfunnel_first_click_adSourceDirty")
  -- depends_on: test.attr_myfirstfunnel_model




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_myfirstfunnel_join_to_attr_prepare_with_qid
        join  test.attr_myfirstfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out



  