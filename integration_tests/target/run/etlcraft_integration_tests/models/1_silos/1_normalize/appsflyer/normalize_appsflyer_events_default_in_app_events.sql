

  create view test.normalize_appsflyer_events_default_in_app_events__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'event_time') AS __date, 
        JSONExtractString(_airbyte_data, 'ad_unit') AS ad_unit, 
        JSONExtractString(_airbyte_data, 'advertising_id') AS advertising_id, 
        JSONExtractString(_airbyte_data, 'af_ad') AS af_ad, 
        JSONExtractString(_airbyte_data, 'af_ad_id') AS af_ad_id, 
        JSONExtractString(_airbyte_data, 'af_ad_type') AS af_ad_type, 
        JSONExtractString(_airbyte_data, 'af_adset') AS af_adset, 
        JSONExtractString(_airbyte_data, 'af_adset_id') AS af_adset_id, 
        JSONExtractString(_airbyte_data, 'af_attribution_lookback') AS af_attribution_lookback, 
        JSONExtractString(_airbyte_data, 'af_c_id') AS af_c_id, 
        JSONExtractString(_airbyte_data, 'af_channel') AS af_channel, 
        JSONExtractString(_airbyte_data, 'af_cost_currency') AS af_cost_currency, 
        JSONExtractString(_airbyte_data, 'af_cost_model') AS af_cost_model, 
        JSONExtractString(_airbyte_data, 'af_cost_value') AS af_cost_value, 
        JSONExtractString(_airbyte_data, 'af_keywords') AS af_keywords, 
        JSONExtractString(_airbyte_data, 'af_prt') AS af_prt, 
        JSONExtractString(_airbyte_data, 'af_reengagement_window') AS af_reengagement_window, 
        JSONExtractString(_airbyte_data, 'af_siteid') AS af_siteid, 
        JSONExtractString(_airbyte_data, 'af_sub1') AS af_sub1, 
        JSONExtractString(_airbyte_data, 'af_sub2') AS af_sub2, 
        JSONExtractString(_airbyte_data, 'af_sub3') AS af_sub3, 
        JSONExtractString(_airbyte_data, 'af_sub4') AS af_sub4, 
        JSONExtractString(_airbyte_data, 'af_sub5') AS af_sub5, 
        JSONExtractString(_airbyte_data, 'af_sub_siteid') AS af_sub_siteid, 
        JSONExtractString(_airbyte_data, 'amazon_aid') AS amazon_aid, 
        JSONExtractString(_airbyte_data, 'android_id') AS android_id, 
        JSONExtractString(_airbyte_data, 'app_id') AS app_id, 
        JSONExtractString(_airbyte_data, 'app_name') AS app_name, 
        JSONExtractString(_airbyte_data, 'app_type') AS app_type, 
        JSONExtractString(_airbyte_data, 'app_version') AS app_version, 
        JSONExtractString(_airbyte_data, 'appsflyer_id') AS appsflyer_id, 
        JSONExtractString(_airbyte_data, 'att') AS att, 
        JSONExtractString(_airbyte_data, 'attributed_touch_time') AS attributed_touch_time, 
        JSONExtractString(_airbyte_data, 'attributed_touch_type') AS attributed_touch_type, 
        JSONExtractString(_airbyte_data, 'blocked_reason') AS blocked_reason, 
        JSONExtractString(_airbyte_data, 'blocked_reason_rule') AS blocked_reason_rule, 
        JSONExtractString(_airbyte_data, 'blocked_reason_value') AS blocked_reason_value, 
        JSONExtractString(_airbyte_data, 'blocked_sub_reason') AS blocked_sub_reason, 
        JSONExtractString(_airbyte_data, 'bundle_id') AS bundle_id, 
        JSONExtractString(_airbyte_data, 'campaign') AS campaign, 
        JSONExtractString(_airbyte_data, 'campaign_type') AS campaign_type, 
        JSONExtractString(_airbyte_data, 'carrier') AS carrier, 
        JSONExtractString(_airbyte_data, 'city') AS city, 
        JSONExtractString(_airbyte_data, 'contributor1_af_prt') AS contributor1_af_prt, 
        JSONExtractString(_airbyte_data, 'contributor1_campaign') AS contributor1_campaign, 
        JSONExtractString(_airbyte_data, 'contributor1_match_type') AS contributor1_match_type, 
        JSONExtractString(_airbyte_data, 'contributor1_media_source') AS contributor1_media_source, 
        JSONExtractString(_airbyte_data, 'contributor1_touch_time') AS contributor1_touch_time, 
        JSONExtractString(_airbyte_data, 'contributor1_touch_type') AS contributor1_touch_type, 
        JSONExtractString(_airbyte_data, 'contributor2_af_prt') AS contributor2_af_prt, 
        JSONExtractString(_airbyte_data, 'contributor2_campaign') AS contributor2_campaign, 
        JSONExtractString(_airbyte_data, 'contributor2_match_type') AS contributor2_match_type, 
        JSONExtractString(_airbyte_data, 'contributor2_media_source') AS contributor2_media_source, 
        JSONExtractString(_airbyte_data, 'contributor2_touch_time') AS contributor2_touch_time, 
        JSONExtractString(_airbyte_data, 'contributor2_touch_type') AS contributor2_touch_type, 
        JSONExtractString(_airbyte_data, 'contributor3_af_prt') AS contributor3_af_prt, 
        JSONExtractString(_airbyte_data, 'contributor3_campaign') AS contributor3_campaign, 
        JSONExtractString(_airbyte_data, 'contributor3_match_type') AS contributor3_match_type, 
        JSONExtractString(_airbyte_data, 'contributor3_media_source') AS contributor3_media_source, 
        JSONExtractString(_airbyte_data, 'contributor3_touch_time') AS contributor3_touch_time, 
        JSONExtractString(_airbyte_data, 'contributor3_touch_type') AS contributor3_touch_type, 
        JSONExtractString(_airbyte_data, 'conversion_type') AS conversion_type, 
        JSONExtractString(_airbyte_data, 'country_code') AS country_code, 
        JSONExtractString(_airbyte_data, 'custom_data') AS custom_data, 
        JSONExtractString(_airbyte_data, 'customer_user_id') AS customer_user_id, 
        JSONExtractString(_airbyte_data, 'deeplink_url') AS deeplink_url, 
        JSONExtractString(_airbyte_data, 'device_category') AS device_category, 
        JSONExtractString(_airbyte_data, 'device_download_time') AS device_download_time, 
        JSONExtractString(_airbyte_data, 'device_model') AS device_model, 
        JSONExtractString(_airbyte_data, 'device_type') AS device_type, 
        JSONExtractString(_airbyte_data, 'dma') AS dma, 
        JSONExtractString(_airbyte_data, 'event_name') AS event_name, 
        JSONExtractString(_airbyte_data, 'event_revenue') AS event_revenue, 
        JSONExtractString(_airbyte_data, 'event_revenue_currency') AS event_revenue_currency, 
        JSONExtractString(_airbyte_data, 'event_revenue_usd') AS event_revenue_usd, 
        JSONExtractString(_airbyte_data, 'event_source') AS event_source, 
        JSONExtractString(_airbyte_data, 'event_time') AS event_time, 
        JSONExtractString(_airbyte_data, 'event_value') AS event_value, 
        JSONExtractString(_airbyte_data, 'gp_broadcast_referrer') AS gp_broadcast_referrer, 
        JSONExtractString(_airbyte_data, 'gp_click_time') AS gp_click_time, 
        JSONExtractString(_airbyte_data, 'gp_install_begin') AS gp_install_begin, 
        JSONExtractString(_airbyte_data, 'gp_referrer') AS gp_referrer, 
        JSONExtractString(_airbyte_data, 'http_referrer') AS http_referrer, 
        JSONExtractString(_airbyte_data, 'idfa') AS idfa, 
        JSONExtractString(_airbyte_data, 'idfv') AS idfv, 
        JSONExtractString(_airbyte_data, 'imei') AS imei, 
        JSONExtractString(_airbyte_data, 'impressions') AS impressions, 
        JSONExtractString(_airbyte_data, 'install_app_store') AS install_app_store, 
        JSONExtractString(_airbyte_data, 'install_time') AS install_time, 
        JSONExtractString(_airbyte_data, 'ip') AS ip, 
        JSONExtractString(_airbyte_data, 'is_lat') AS is_lat, 
        JSONExtractString(_airbyte_data, 'is_primary_attribution') AS is_primary_attribution, 
        JSONExtractString(_airbyte_data, 'is_receipt_validated') AS is_receipt_validated, 
        JSONExtractString(_airbyte_data, 'is_retargeting') AS is_retargeting, 
        JSONExtractString(_airbyte_data, 'keyword_id') AS keyword_id, 
        JSONExtractString(_airbyte_data, 'keyword_match_type') AS keyword_match_type, 
        JSONExtractString(_airbyte_data, 'language') AS language, 
        JSONExtractString(_airbyte_data, 'match_type') AS match_type, 
        JSONExtractString(_airbyte_data, 'media_source') AS media_source, 
        JSONExtractString(_airbyte_data, 'mediation_network') AS mediation_network, 
        JSONExtractString(_airbyte_data, 'monetization_network') AS monetization_network, 
        JSONExtractString(_airbyte_data, 'network_account_id') AS network_account_id, 
        JSONExtractString(_airbyte_data, 'oaid') AS oaid, 
        JSONExtractString(_airbyte_data, 'operator') AS operator, 
        JSONExtractString(_airbyte_data, 'original_url') AS original_url, 
        JSONExtractString(_airbyte_data, 'os_version') AS os_version, 
        JSONExtractString(_airbyte_data, 'placement') AS placement, 
        JSONExtractString(_airbyte_data, 'platform') AS platform, 
        JSONExtractString(_airbyte_data, 'postal_code') AS postal_code, 
        JSONExtractString(_airbyte_data, 'region') AS region, 
        JSONExtractString(_airbyte_data, 'rejected_reason') AS rejected_reason, 
        JSONExtractString(_airbyte_data, 'rejected_reason_value') AS rejected_reason_value, 
        JSONExtractString(_airbyte_data, 'retargeting_conversion_type') AS retargeting_conversion_type, 
        JSONExtractString(_airbyte_data, 'sdk_version') AS sdk_version, 
        JSONExtractString(_airbyte_data, 'segment') AS segment, 
        JSONExtractString(_airbyte_data, 'state') AS state, 
        JSONExtractString(_airbyte_data, 'store_reinstall') AS store_reinstall, 
        JSONExtractString(_airbyte_data, 'user_agent') AS user_agent, 
        JSONExtractString(_airbyte_data, 'wifi') AS wifi,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_appsflyer_default_accountid_in_app_events') AS _dbt_source_relation,
        toString("_airbyte_ab_id") AS _airbyte_ab_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_emitted_at") AS _airbyte_emitted_at
FROM test.datacraft_clientname_raw__stream_appsflyer_default_accountid_in_app_events
)

)


--"event_value":"{\"rent_id\":\"226738375\",\"car_id\":\"18793\",\"user_id\":\"1cf9c961e89019bac2cef4bebb421701\",\"device_lat_long\":\"\"}",

--Missing columns: '_airbyte_extracted_at' - в данных _airbyte_emitted_at - макрос normalize добавлена строка 112
  )