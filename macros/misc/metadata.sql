{%- macro metadata() -%}
entities:
  Account:
    keys:
    - name: accountName
  Product:
    keys:
    - name: productName
  AdSource:
    keys:
    - name: adSourceDirty
  UtmParams:
    keys:
    - name: utmSource
    - name: utmMedium
    - name: utmCampaign
    - name: utmTerm
    - name: utmContent
  UtmHash:
    keys:
    - name: utmHash
  AdPhrase:
    keys:
    - name: adPhraseId
  AdCampaign:
    keys:
    - name: adCampaignName
  AdGroup:
    keys:
    - name: adGroupName
  Ad:
    keys:
    - name: adId
  YmClient:
    glue: yes
    keys:
    - name: clientId
  CrmUser:
    glue: yes
    keys:
    - name: crmUserId
  PromoCode:
    keys:
    - name: promoCode
  City:
    keys:
    - name: cityName
  AppMetricaDevice:
    glue: yes
    keys:
    - name: appmetricaDeviceId
  MobileAdsId:
    keys:
    - name: mobileAdsId
  AppMetricaDeviceId:
    keys:
    - name: appmetricaDeviceId
  OsName:
    keys:
    - name: osName
  Visit:
    keys:
    - name: visitId
  Transaction:
    keys:
    - name: transactionId
  AppSession:
    keys:
    {# - name: appSessionId #}
    - name: installationDeviceId
links: 
  AdCostStat:
    pipeline: datestat
    keys:
    - name: __date 
    - name: reportType
    entities:
    - Account
    - AdSource 
    - AdCampaign 
    - AdGroup 
    - Ad 
    - AdPhrase  
    - UtmParams 
    - UtmHash
  MediaplanStat:
    keys:
    - name: planCostDate
    entities:
    - Account
    - Product
    - CityCode
    - AdSource
    - UtmParams
  AppInstallStat:
    pipeline: events
    keys:
    - name: event_datetime
    entities:
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
    - AdSource
    - UtmParams 
    - UtmHash
  AppEventStat:
    pipeline: events
    keys:
    - name: event_datetime
    entities:
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - Transaction
    - PromoCode
    - OsName
    - City
  AppSessionStat:
    pipeline: events
    keys:
    - name: event_datetime
    entities:
    - Account
    - AppSession
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
  AppDeeplinkStat:
    pipeline: events
    keys:
    - name: event_datetime
    entities:
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
    - AdSource
    - UtmParams  
    - UtmHash
  VisitStat:
    pipeline: events
    keys:
    - name: event_datetime
    entities:
    - Account 
    - Visit
    - YmClient
    - PromoCode
    - OsName
    - City
    - AdSource
    - UtmParams  
    - UtmHash
  AppProfileMatching:
    pipeline: events
    entities:
    - AppMetricaDeviceId
    - CrmUser
    - City
registries:
  AppMetricaDeviceId:
    - incremental_appmetrica_registry_default_profiles
glue_models:
  full_link_visit_stat:
    datetime_field: event_datetime
    cols:
    - VisitStatHash
    - YmClientHash
  full_link_app_event_stat:
    datetime_field: event_datetime
    cols:
    - AppEventStatHash
    - CrmUserHash 
    - AppMetricaDeviceIdHash
  full_link_app_install_stat:
    datetime_field: event_datetime
    cols:
    - AppInstallStatHash
    - CrmUserHash
    - AppMetricaDeviceIdHash
  full_link_app_session_stat:
    datetime_field: event_datetime
    cols:
    - AppSessionStatHash
    - CrmUserHash
    - AppMetricaDeviceIdHash
  full_link_app_deeplink_stat:
    datetime_field: deeplinkDateTime
    cols:
    - AppDeeplinkStatHash
    - CrmUserHash
    - AppMetricaDeviceIdHash
  full_link_app_profile_matching:
    datetime_field: toDateTime(0)
    cols:
    - AppProfileMatchingHash
    - AppMetricaDeviceIdHash
{%- endmacro -%}
