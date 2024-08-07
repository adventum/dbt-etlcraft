
  
    
    
        
        insert into test.dataset_event_table2__dbt_backup ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "adCampaignName", "adId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adText", "adCost", "impressions", "clicks", "__emitted_at", "__link", "adGroupName", "adPhraseId", "AdCostStatHash", "UtmHashHash", "__id", "__datetime", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash", "event_datetime", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "transactionId", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "touch_type", "touch_time", "install_time", "event_time", "event_name", "event_source", "partner", "media_source", "campaign", "site_id", "ad", "country_code", "city", "appsflyer_id", "custom_uid", "platform", "is_retargeting", "is_primary_attribution", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "AppMetricaDeviceHash", "CrmUserHash", "qid", "AppProfileMatchingHash")
  -- depends_on: test.full_datestat
-- depends_on: test.full_events
-- depends_on: test.attr_myfirstfunnel_final_table


   
    
   
    
  WITH final_query AS (

  
    SELECT * FROM (

(
SELECT
        toDate("__date") as __date ,
        toString("reportType") as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString("adCampaignName") as adCampaignName ,
        toString("adId") as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString("adTitle1") as adTitle1 ,
        toString("adText") as adText ,
        toFloat64("adCost") as adCost ,
        toInt64("impressions") as impressions ,
        toInt64("clicks") as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString("adGroupName") as adGroupName ,
        toString("adPhraseId") as adPhraseId ,
        toString("AdCostStatHash") as AdCostStatHash ,
        toString("UtmHashHash") as UtmHashHash ,
        toString("__id") as __id ,
        toDateTime("__datetime") as __datetime ,
        toString("utm_base_url") as utm_base_url ,
        toString("utm_utmSource") as utm_utmSource ,
        toString("utm_utmMedium") as utm_utmMedium ,
        toString("utm_utmCampaign") as utm_utmCampaign ,
        toString("utm_project") as utm_project ,
        toString("utm_utmContent") as utm_utmContent ,
        toString("utm_strategy") as utm_strategy ,
        toString("utm_audience") as utm_audience ,
        toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
        toDateTime(0) as event_datetime ,
        toString('') as appmetricaDeviceId ,
        toString('') as mobileAdsId ,
        toString('') as crmUserId ,
        toString('') as promoCode ,
        toString('') as osName ,
        toString('') as cityName ,
        toString('') as transactionId ,
        toUInt64(0) as sessions ,
        toUInt64(0) as addToCartSessions ,
        toUInt64(0) as cartViewSessions ,
        toUInt64(0) as checkoutSessions ,
        toUInt64(0) as webSalesSessions ,
        toUInt64(0) as sales ,
        toFloat64(0) as amountSales ,
        toUInt64(0) as registrationCardSessions ,
        toUInt64(0) as registrationButtonClick ,
        toUInt64(0) as linkingCardToPhoneNumberSessions ,
        toUInt64(0) as registrationLendingPromotionsSessions ,
        toUInt64(0) as registrationCashbackSessions ,
        toUInt64(0) as instantDiscountActivationSessions ,
        toUInt64(0) as couponActivationSessions ,
        toUInt64(0) as participationInLotterySessions ,
        toUInt64(0) as pagesViews ,
        toUInt64(0) as screenView ,
        toUInt64(0) as installApp ,
        toUInt64(0) as installs ,
        toString('') as installationDeviceId ,
        toString('') as touch_type ,
        toDateTime(0) as touch_time ,
        toDateTime(0) as install_time ,
        toDateTime(0) as event_time ,
        toString('') as event_name ,
        toString('') as event_source ,
        toString('') as partner ,
        toString('') as media_source ,
        toString('') as campaign ,
        toString('') as site_id ,
        toString('') as ad ,
        toString('') as country_code ,
        toString('') as city ,
        toString('') as appsflyer_id ,
        toString('') as custom_uid ,
        toString('') as platform ,
        toString('') as is_retargeting ,
        toString('') as is_primary_attribution ,
        toString('') as visitId ,
        toString('') as clientId ,
        toString('') as cityCode ,
        toUInt64(0) as pageViews ,
        toString('') as VisitStatHash ,
        toString('') as AppInstallStatHash ,
        toString('') as AppEventStatHash ,
        toString('') as AppSessionStatHash ,
        toString('') as AppDeeplinkStatHash ,
        toString('') as YmClientHash ,
        toString('') as AppMetricaDeviceHash ,
        toString('') as CrmUserHash ,
        toUInt64(0) as qid ,
        toString('') as AppProfileMatchingHash 
FROM test.full_datestat
)

UNION ALL


(
SELECT
        toDate("__date") as __date ,
        toString('') as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString('') as adCampaignName ,
        toString('') as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString('') as adTitle1 ,
        toString('') as adText ,
        toFloat64(0) as adCost ,
        toInt64(0) as impressions ,
        toInt64(0) as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString('') as adGroupName ,
        toString('') as adPhraseId ,
        toString('') as AdCostStatHash ,
        toString("UtmHashHash") as UtmHashHash ,
        toString("__id") as __id ,
        toDateTime("__datetime") as __datetime ,
        toString("utm_base_url") as utm_base_url ,
        toString("utm_utmSource") as utm_utmSource ,
        toString("utm_utmMedium") as utm_utmMedium ,
        toString("utm_utmCampaign") as utm_utmCampaign ,
        toString("utm_project") as utm_project ,
        toString("utm_utmContent") as utm_utmContent ,
        toString("utm_strategy") as utm_strategy ,
        toString("utm_audience") as utm_audience ,
        toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
        toDateTime("event_datetime") as event_datetime ,
        toString("appmetricaDeviceId") as appmetricaDeviceId ,
        toString("mobileAdsId") as mobileAdsId ,
        toString("crmUserId") as crmUserId ,
        toString("promoCode") as promoCode ,
        toString("osName") as osName ,
        toString("cityName") as cityName ,
        toString("transactionId") as transactionId ,
        toUInt64("sessions") as sessions ,
        toUInt64("addToCartSessions") as addToCartSessions ,
        toUInt64("cartViewSessions") as cartViewSessions ,
        toUInt64("checkoutSessions") as checkoutSessions ,
        toUInt64("webSalesSessions") as webSalesSessions ,
        toUInt64("sales") as sales ,
        toFloat64("amountSales") as amountSales ,
        toUInt64("registrationCardSessions") as registrationCardSessions ,
        toUInt64("registrationButtonClick") as registrationButtonClick ,
        toUInt64("linkingCardToPhoneNumberSessions") as linkingCardToPhoneNumberSessions ,
        toUInt64("registrationLendingPromotionsSessions") as registrationLendingPromotionsSessions ,
        toUInt64("registrationCashbackSessions") as registrationCashbackSessions ,
        toUInt64("instantDiscountActivationSessions") as instantDiscountActivationSessions ,
        toUInt64("couponActivationSessions") as couponActivationSessions ,
        toUInt64("participationInLotterySessions") as participationInLotterySessions ,
        toUInt64("pagesViews") as pagesViews ,
        toUInt64("screenView") as screenView ,
        toUInt64("installApp") as installApp ,
        toUInt64("installs") as installs ,
        toString("installationDeviceId") as installationDeviceId ,
        toString("touch_type") as touch_type ,
        toDateTime("touch_time") as touch_time ,
        toDateTime("install_time") as install_time ,
        toDateTime("event_time") as event_time ,
        toString("event_name") as event_name ,
        toString("event_source") as event_source ,
        toString("partner") as partner ,
        toString("media_source") as media_source ,
        toString("campaign") as campaign ,
        toString("site_id") as site_id ,
        toString("ad") as ad ,
        toString("country_code") as country_code ,
        toString("city") as city ,
        toString("appsflyer_id") as appsflyer_id ,
        toString("custom_uid") as custom_uid ,
        toString("platform") as platform ,
        toString("is_retargeting") as is_retargeting ,
        toString("is_primary_attribution") as is_primary_attribution ,
        toString("visitId") as visitId ,
        toString("clientId") as clientId ,
        toString("cityCode") as cityCode ,
        toUInt64("pageViews") as pageViews ,
        toString("VisitStatHash") as VisitStatHash ,
        toString("AppInstallStatHash") as AppInstallStatHash ,
        toString("AppEventStatHash") as AppEventStatHash ,
        toString("AppSessionStatHash") as AppSessionStatHash ,
        toString("AppDeeplinkStatHash") as AppDeeplinkStatHash ,
        toString("YmClientHash") as YmClientHash ,
        toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
        toString("CrmUserHash") as CrmUserHash ,
        toUInt64("qid") as qid ,
        toString("AppProfileMatchingHash") as AppProfileMatchingHash 
FROM test.full_events
)

) 
    WHERE 
    splitByChar('_', __table_name)[6] = 'yd'
    and 
    splitByChar('_', __table_name)[8] = 'accountid'
    and 
    splitByChar('_', __table_name)[7] = 'default'
    UNION ALL
  
    SELECT * FROM (

(
SELECT
        toDate("__date") as __date ,
        toString("reportType") as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString("adCampaignName") as adCampaignName ,
        toString("adId") as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString("adTitle1") as adTitle1 ,
        toString("adText") as adText ,
        toFloat64("adCost") as adCost ,
        toInt64("impressions") as impressions ,
        toInt64("clicks") as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString("adGroupName") as adGroupName ,
        toString("adPhraseId") as adPhraseId ,
        toString("AdCostStatHash") as AdCostStatHash ,
        toString("UtmHashHash") as UtmHashHash ,
        toString("__id") as __id ,
        toDateTime("__datetime") as __datetime ,
        toString("utm_base_url") as utm_base_url ,
        toString("utm_utmSource") as utm_utmSource ,
        toString("utm_utmMedium") as utm_utmMedium ,
        toString("utm_utmCampaign") as utm_utmCampaign ,
        toString("utm_project") as utm_project ,
        toString("utm_utmContent") as utm_utmContent ,
        toString("utm_strategy") as utm_strategy ,
        toString("utm_audience") as utm_audience ,
        toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
        toDateTime(0) as event_datetime ,
        toString('') as appmetricaDeviceId ,
        toString('') as mobileAdsId ,
        toString('') as crmUserId ,
        toString('') as promoCode ,
        toString('') as osName ,
        toString('') as cityName ,
        toString('') as transactionId ,
        toUInt64(0) as sessions ,
        toUInt64(0) as addToCartSessions ,
        toUInt64(0) as cartViewSessions ,
        toUInt64(0) as checkoutSessions ,
        toUInt64(0) as webSalesSessions ,
        toUInt64(0) as sales ,
        toFloat64(0) as amountSales ,
        toUInt64(0) as registrationCardSessions ,
        toUInt64(0) as registrationButtonClick ,
        toUInt64(0) as linkingCardToPhoneNumberSessions ,
        toUInt64(0) as registrationLendingPromotionsSessions ,
        toUInt64(0) as registrationCashbackSessions ,
        toUInt64(0) as instantDiscountActivationSessions ,
        toUInt64(0) as couponActivationSessions ,
        toUInt64(0) as participationInLotterySessions ,
        toUInt64(0) as pagesViews ,
        toUInt64(0) as screenView ,
        toUInt64(0) as installApp ,
        toUInt64(0) as installs ,
        toString('') as installationDeviceId ,
        toString('') as touch_type ,
        toDateTime(0) as touch_time ,
        toDateTime(0) as install_time ,
        toDateTime(0) as event_time ,
        toString('') as event_name ,
        toString('') as event_source ,
        toString('') as partner ,
        toString('') as media_source ,
        toString('') as campaign ,
        toString('') as site_id ,
        toString('') as ad ,
        toString('') as country_code ,
        toString('') as city ,
        toString('') as appsflyer_id ,
        toString('') as custom_uid ,
        toString('') as platform ,
        toString('') as is_retargeting ,
        toString('') as is_primary_attribution ,
        toString('') as visitId ,
        toString('') as clientId ,
        toString('') as cityCode ,
        toUInt64(0) as pageViews ,
        toString('') as VisitStatHash ,
        toString('') as AppInstallStatHash ,
        toString('') as AppEventStatHash ,
        toString('') as AppSessionStatHash ,
        toString('') as AppDeeplinkStatHash ,
        toString('') as YmClientHash ,
        toString('') as AppMetricaDeviceHash ,
        toString('') as CrmUserHash ,
        toUInt64(0) as qid ,
        toString('') as AppProfileMatchingHash 
FROM test.full_datestat
)

UNION ALL


(
SELECT
        toDate("__date") as __date ,
        toString('') as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString('') as adCampaignName ,
        toString('') as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString('') as adTitle1 ,
        toString('') as adText ,
        toFloat64(0) as adCost ,
        toInt64(0) as impressions ,
        toInt64(0) as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString('') as adGroupName ,
        toString('') as adPhraseId ,
        toString('') as AdCostStatHash ,
        toString("UtmHashHash") as UtmHashHash ,
        toString("__id") as __id ,
        toDateTime("__datetime") as __datetime ,
        toString("utm_base_url") as utm_base_url ,
        toString("utm_utmSource") as utm_utmSource ,
        toString("utm_utmMedium") as utm_utmMedium ,
        toString("utm_utmCampaign") as utm_utmCampaign ,
        toString("utm_project") as utm_project ,
        toString("utm_utmContent") as utm_utmContent ,
        toString("utm_strategy") as utm_strategy ,
        toString("utm_audience") as utm_audience ,
        toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
        toDateTime("event_datetime") as event_datetime ,
        toString("appmetricaDeviceId") as appmetricaDeviceId ,
        toString("mobileAdsId") as mobileAdsId ,
        toString("crmUserId") as crmUserId ,
        toString("promoCode") as promoCode ,
        toString("osName") as osName ,
        toString("cityName") as cityName ,
        toString("transactionId") as transactionId ,
        toUInt64("sessions") as sessions ,
        toUInt64("addToCartSessions") as addToCartSessions ,
        toUInt64("cartViewSessions") as cartViewSessions ,
        toUInt64("checkoutSessions") as checkoutSessions ,
        toUInt64("webSalesSessions") as webSalesSessions ,
        toUInt64("sales") as sales ,
        toFloat64("amountSales") as amountSales ,
        toUInt64("registrationCardSessions") as registrationCardSessions ,
        toUInt64("registrationButtonClick") as registrationButtonClick ,
        toUInt64("linkingCardToPhoneNumberSessions") as linkingCardToPhoneNumberSessions ,
        toUInt64("registrationLendingPromotionsSessions") as registrationLendingPromotionsSessions ,
        toUInt64("registrationCashbackSessions") as registrationCashbackSessions ,
        toUInt64("instantDiscountActivationSessions") as instantDiscountActivationSessions ,
        toUInt64("couponActivationSessions") as couponActivationSessions ,
        toUInt64("participationInLotterySessions") as participationInLotterySessions ,
        toUInt64("pagesViews") as pagesViews ,
        toUInt64("screenView") as screenView ,
        toUInt64("installApp") as installApp ,
        toUInt64("installs") as installs ,
        toString("installationDeviceId") as installationDeviceId ,
        toString("touch_type") as touch_type ,
        toDateTime("touch_time") as touch_time ,
        toDateTime("install_time") as install_time ,
        toDateTime("event_time") as event_time ,
        toString("event_name") as event_name ,
        toString("event_source") as event_source ,
        toString("partner") as partner ,
        toString("media_source") as media_source ,
        toString("campaign") as campaign ,
        toString("site_id") as site_id ,
        toString("ad") as ad ,
        toString("country_code") as country_code ,
        toString("city") as city ,
        toString("appsflyer_id") as appsflyer_id ,
        toString("custom_uid") as custom_uid ,
        toString("platform") as platform ,
        toString("is_retargeting") as is_retargeting ,
        toString("is_primary_attribution") as is_primary_attribution ,
        toString("visitId") as visitId ,
        toString("clientId") as clientId ,
        toString("cityCode") as cityCode ,
        toUInt64("pageViews") as pageViews ,
        toString("VisitStatHash") as VisitStatHash ,
        toString("AppInstallStatHash") as AppInstallStatHash ,
        toString("AppEventStatHash") as AppEventStatHash ,
        toString("AppSessionStatHash") as AppSessionStatHash ,
        toString("AppDeeplinkStatHash") as AppDeeplinkStatHash ,
        toString("YmClientHash") as YmClientHash ,
        toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
        toString("CrmUserHash") as CrmUserHash ,
        toUInt64("qid") as qid ,
        toString("AppProfileMatchingHash") as AppProfileMatchingHash 
FROM test.full_events
)

) 
    WHERE 
    splitByChar('_', __table_name)[6] = 'appmetrica'
    and 
    splitByChar('_', __table_name)[8] = 'accountid'
    and 
    splitByChar('_', __table_name)[7] = 'default'
    UNION ALL
  
    SELECT * FROM (

(
SELECT
        toDate("__date") as __date ,
        toString("reportType") as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString("adCampaignName") as adCampaignName ,
        toString("adId") as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString("adTitle1") as adTitle1 ,
        toString("adText") as adText ,
        toFloat64("adCost") as adCost ,
        toInt64("impressions") as impressions ,
        toInt64("clicks") as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString("adGroupName") as adGroupName ,
        toString("adPhraseId") as adPhraseId ,
        toString("AdCostStatHash") as AdCostStatHash ,
        toString("UtmHashHash") as UtmHashHash ,
        toString("__id") as __id ,
        toDateTime("__datetime") as __datetime ,
        toString("utm_base_url") as utm_base_url ,
        toString("utm_utmSource") as utm_utmSource ,
        toString("utm_utmMedium") as utm_utmMedium ,
        toString("utm_utmCampaign") as utm_utmCampaign ,
        toString("utm_project") as utm_project ,
        toString("utm_utmContent") as utm_utmContent ,
        toString("utm_strategy") as utm_strategy ,
        toString("utm_audience") as utm_audience ,
        toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
        toDateTime(0) as event_datetime ,
        toString('') as appmetricaDeviceId ,
        toString('') as mobileAdsId ,
        toString('') as crmUserId ,
        toString('') as promoCode ,
        toString('') as osName ,
        toString('') as cityName ,
        toString('') as transactionId ,
        toUInt64(0) as sessions ,
        toUInt64(0) as addToCartSessions ,
        toUInt64(0) as cartViewSessions ,
        toUInt64(0) as checkoutSessions ,
        toUInt64(0) as webSalesSessions ,
        toUInt64(0) as sales ,
        toFloat64(0) as amountSales ,
        toUInt64(0) as registrationCardSessions ,
        toUInt64(0) as registrationButtonClick ,
        toUInt64(0) as linkingCardToPhoneNumberSessions ,
        toUInt64(0) as registrationLendingPromotionsSessions ,
        toUInt64(0) as registrationCashbackSessions ,
        toUInt64(0) as instantDiscountActivationSessions ,
        toUInt64(0) as couponActivationSessions ,
        toUInt64(0) as participationInLotterySessions ,
        toUInt64(0) as pagesViews ,
        toUInt64(0) as screenView ,
        toUInt64(0) as installApp ,
        toUInt64(0) as installs ,
        toString('') as installationDeviceId ,
        toString('') as touch_type ,
        toDateTime(0) as touch_time ,
        toDateTime(0) as install_time ,
        toDateTime(0) as event_time ,
        toString('') as event_name ,
        toString('') as event_source ,
        toString('') as partner ,
        toString('') as media_source ,
        toString('') as campaign ,
        toString('') as site_id ,
        toString('') as ad ,
        toString('') as country_code ,
        toString('') as city ,
        toString('') as appsflyer_id ,
        toString('') as custom_uid ,
        toString('') as platform ,
        toString('') as is_retargeting ,
        toString('') as is_primary_attribution ,
        toString('') as visitId ,
        toString('') as clientId ,
        toString('') as cityCode ,
        toUInt64(0) as pageViews ,
        toString('') as VisitStatHash ,
        toString('') as AppInstallStatHash ,
        toString('') as AppEventStatHash ,
        toString('') as AppSessionStatHash ,
        toString('') as AppDeeplinkStatHash ,
        toString('') as YmClientHash ,
        toString('') as AppMetricaDeviceHash ,
        toString('') as CrmUserHash ,
        toUInt64(0) as qid ,
        toString('') as AppProfileMatchingHash 
FROM test.full_datestat
)

UNION ALL


(
SELECT
        toDate("__date") as __date ,
        toString('') as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString('') as adCampaignName ,
        toString('') as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString('') as adTitle1 ,
        toString('') as adText ,
        toFloat64(0) as adCost ,
        toInt64(0) as impressions ,
        toInt64(0) as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString('') as adGroupName ,
        toString('') as adPhraseId ,
        toString('') as AdCostStatHash ,
        toString("UtmHashHash") as UtmHashHash ,
        toString("__id") as __id ,
        toDateTime("__datetime") as __datetime ,
        toString("utm_base_url") as utm_base_url ,
        toString("utm_utmSource") as utm_utmSource ,
        toString("utm_utmMedium") as utm_utmMedium ,
        toString("utm_utmCampaign") as utm_utmCampaign ,
        toString("utm_project") as utm_project ,
        toString("utm_utmContent") as utm_utmContent ,
        toString("utm_strategy") as utm_strategy ,
        toString("utm_audience") as utm_audience ,
        toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
        toDateTime("event_datetime") as event_datetime ,
        toString("appmetricaDeviceId") as appmetricaDeviceId ,
        toString("mobileAdsId") as mobileAdsId ,
        toString("crmUserId") as crmUserId ,
        toString("promoCode") as promoCode ,
        toString("osName") as osName ,
        toString("cityName") as cityName ,
        toString("transactionId") as transactionId ,
        toUInt64("sessions") as sessions ,
        toUInt64("addToCartSessions") as addToCartSessions ,
        toUInt64("cartViewSessions") as cartViewSessions ,
        toUInt64("checkoutSessions") as checkoutSessions ,
        toUInt64("webSalesSessions") as webSalesSessions ,
        toUInt64("sales") as sales ,
        toFloat64("amountSales") as amountSales ,
        toUInt64("registrationCardSessions") as registrationCardSessions ,
        toUInt64("registrationButtonClick") as registrationButtonClick ,
        toUInt64("linkingCardToPhoneNumberSessions") as linkingCardToPhoneNumberSessions ,
        toUInt64("registrationLendingPromotionsSessions") as registrationLendingPromotionsSessions ,
        toUInt64("registrationCashbackSessions") as registrationCashbackSessions ,
        toUInt64("instantDiscountActivationSessions") as instantDiscountActivationSessions ,
        toUInt64("couponActivationSessions") as couponActivationSessions ,
        toUInt64("participationInLotterySessions") as participationInLotterySessions ,
        toUInt64("pagesViews") as pagesViews ,
        toUInt64("screenView") as screenView ,
        toUInt64("installApp") as installApp ,
        toUInt64("installs") as installs ,
        toString("installationDeviceId") as installationDeviceId ,
        toString("touch_type") as touch_type ,
        toDateTime("touch_time") as touch_time ,
        toDateTime("install_time") as install_time ,
        toDateTime("event_time") as event_time ,
        toString("event_name") as event_name ,
        toString("event_source") as event_source ,
        toString("partner") as partner ,
        toString("media_source") as media_source ,
        toString("campaign") as campaign ,
        toString("site_id") as site_id ,
        toString("ad") as ad ,
        toString("country_code") as country_code ,
        toString("city") as city ,
        toString("appsflyer_id") as appsflyer_id ,
        toString("custom_uid") as custom_uid ,
        toString("platform") as platform ,
        toString("is_retargeting") as is_retargeting ,
        toString("is_primary_attribution") as is_primary_attribution ,
        toString("visitId") as visitId ,
        toString("clientId") as clientId ,
        toString("cityCode") as cityCode ,
        toUInt64("pageViews") as pageViews ,
        toString("VisitStatHash") as VisitStatHash ,
        toString("AppInstallStatHash") as AppInstallStatHash ,
        toString("AppEventStatHash") as AppEventStatHash ,
        toString("AppSessionStatHash") as AppSessionStatHash ,
        toString("AppDeeplinkStatHash") as AppDeeplinkStatHash ,
        toString("YmClientHash") as YmClientHash ,
        toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
        toString("CrmUserHash") as CrmUserHash ,
        toUInt64("qid") as qid ,
        toString("AppProfileMatchingHash") as AppProfileMatchingHash 
FROM test.full_events
)

) 
    WHERE 
    splitByChar('_', __table_name)[6] = 'ym'
    and 
    splitByChar('_', __table_name)[8] = 'accountid'
    and 
    splitByChar('_', __table_name)[7] = 'default'
  )
SELECT *
FROM final_query

  