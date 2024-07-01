
        
  
    
    
        
        insert into test.combine_events__dbt_new_data_0aa9aeaf_5cd9_435f_8908_a9af65d9d477 ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews")
  -- depends_on: test.join_appmetrica_events
-- depends_on: test.join_ym_events
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

(
SELECT
        toDateTime("__date") as __date ,
        toString("__table_name") as __table_name ,
        toDateTime("event_datetime") as event_datetime ,
        toString("accountName") as accountName ,
        toString("appmetricaDeviceId") as appmetricaDeviceId ,
        toString("mobileAdsId") as mobileAdsId ,
        toString("crmUserId") as crmUserId ,
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
        toFloat64("amountSales") as amountSales ,
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
        toString('') as visitId ,
        toString('') as clientId ,
        toString('') as cityCode ,
        toUInt32(0) as pageViews 
FROM test.join_appmetrica_events
)

UNION ALL


(
SELECT
        toDateTime("__date") as __date ,
        toString("__table_name") as __table_name ,
        toDateTime(0) as event_datetime ,
        toString('') as accountName ,
        toString('') as appmetricaDeviceId ,
        toString('') as mobileAdsId ,
        toString('') as crmUserId ,
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
        toFloat64(0) as amountSales ,
        toUInt8("registrationCardSessions") as registrationCardSessions ,
        toUInt8(0) as registrationButtonClick ,
        toUInt8("linkingCardToPhoneNumberSessions") as linkingCardToPhoneNumberSessions ,
        toUInt8("registrationLendingPromotionsSessions") as registrationLendingPromotionsSessions ,
        toUInt8("registrationCashbackSessions") as registrationCashbackSessions ,
        toUInt8(0) as instantDiscountActivationSessions ,
        toUInt8("couponActivationSessions") as couponActivationSessions ,
        toUInt8("participationInLotterySessions") as participationInLotterySessions ,
        toUInt8(0) as pagesViews ,
        toUInt64(0) as screenView ,
        toUInt8(0) as installApp ,
        toUInt8(0) as installs ,
        toString('') as installationDeviceId ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString("visitId") as visitId ,
        toString("clientId") as clientId ,
        toString("cityCode") as cityCode ,
        toUInt32("pageViews") as pageViews 
FROM test.join_ym_events
)

) 

  
      