-- depends_on: test.combine_events
SELECT *,
  assumeNotNull(CASE 
WHEN __link = 'AppInstallStat' 
    THEN AppInstallStatHash 
WHEN __link = 'AppEventStat' 
    THEN AppEventStatHash 
WHEN __link = 'AppSessionStat' 
    THEN AppSessionStatHash 
WHEN __link = 'AppDeeplinkStat' 
    THEN AppDeeplinkStatHash 
WHEN __link = 'VisitStat' 
    THEN VisitStatHash 

    END) as __id,

  assumeNotNull(CASE 



WHEN __link = 'AppInstallStat' 
        THEN toDateTime(event_datetime)
    
WHEN __link = 'AppEventStat' 
        THEN toDateTime(event_datetime)
    
WHEN __link = 'AppSessionStat' 
        THEN toDateTime(event_datetime)
    
WHEN __link = 'AppDeeplinkStat' 
        THEN toDateTime(event_datetime)
    
WHEN __link = 'VisitStat' 
        THEN toDateTime(__date)
    


    END) as __datetime
FROM (

SELECT 
    *, 
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppInstallStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppInstallStatHash,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(transactionId))), ''), '') || ifnull(nullif(upper(trim(toString(promoCode))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppEventStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(transactionId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(promoCode))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppEventStatHash,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(installationDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppSessionStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(installationDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppSessionStatHash,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppDeeplinkStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppDeeplinkStatHash,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(visitId))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('VisitStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(visitId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as VisitStatHash
    ,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '')))))) as AppMetricaDeviceHash

,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '')))))) as CrmUserHash

,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashHash

,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(clientId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(clientId))), ''), '')))))) as YmClientHash


    


FROM (

        (
            select

                --toLowCardinality('combine_events')  as _dbt_source_relation,
                
                            toDateTime("__date") as __date ,
                            toString("__table_name") as __table_name ,
                            toDateTime("event_datetime") as event_datetime ,
                            toString("accountName") as accountName ,
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("mobileAdsId") as mobileAdsId ,
                            toString("crmUserId") as crmUserId ,
                            toString("visitId") as visitId ,
                            toString("clientId") as clientId ,
                            toString("promoCode") as promoCode ,
                            toString("osName") as osName ,
                            toString("cityName") as cityName ,
                            toString("adSourceDirty") as adSourceDirty ,
                            toString("utmSource") as utmSource ,
                            toString("utmMedium") as utmMedium ,
                            toString("utmCampaign") as utmCampaign ,
                            toString("utmTerm") as utmTerm ,
                            toString("utmContent") as utmContent ,
                            toString("transactionId") as transactionId ,
                            toString("utmHash") as utmHash ,
                            toUInt8("sessions") as sessions ,
                            toUInt8("addToCartSessions") as addToCartSessions ,
                            toUInt8("cartViewSessions") as cartViewSessions ,
                            toUInt8("checkoutSessions") as checkoutSessions ,
                            toUInt8("webSalesSessions") as webSalesSessions ,
                            toUInt8("sales") as sales ,
                            toNullable("amountSales") as amountSales ,
                            toUInt8("registrationCardSessions") as registrationCardSessions ,
                            toUInt8("registrationButtonClick") as registrationButtonClick ,
                            toUInt8("linkingCardToPhoneNumberSessions") as linkingCardToPhoneNumberSessions ,
                            toUInt8("registrationLendingPromotionsSessions") as registrationLendingPromotionsSessions ,
                            toUInt8("registrationCashbackSessions") as registrationCashbackSessions ,
                            toUInt8("instantDiscountActivationSessions") as instantDiscountActivationSessions ,
                            toUInt8("couponActivationSessions") as couponActivationSessions ,
                            toUInt8("participationInLotterySessions") as participationInLotterySessions ,
                            toUInt8("pagesViews") as pagesViews ,
                            toUInt64("screenView") as screenView ,
                            toUInt8("installApp") as installApp ,
                            toUInt8("installs") as installs ,
                            toString("installationDeviceId") as installationDeviceId ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link ,
                            toString("cityCode") as cityCode ,
                            toUInt32("pageViews") as pageViews 

            from test.combine_events
        )

        ) 
    WHERE 
    
        True AND 
        True AND 
        True AND 
        True AND 
        True
    )


-- SETTINGS short_circuit_function_evaluation=force_enable

