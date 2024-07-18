
        
  
    
    
        
        insert into test.incremental_appsflyer_events_default_in_app_events__dbt_new_data_31c0131d_72bd_4972_82b3_838028fc766e ("__date", "ad_unit", "advertising_id", "af_ad", "af_ad_id", "af_ad_type", "af_adset", "af_adset_id", "af_attribution_lookback", "af_c_id", "af_channel", "af_cost_currency", "af_cost_model", "af_cost_value", "af_keywords", "af_prt", "af_reengagement_window", "af_siteid", "af_sub1", "af_sub2", "af_sub3", "af_sub4", "af_sub5", "af_sub_siteid", "amazon_aid", "android_id", "app_id", "app_name", "app_type", "app_version", "appsflyer_id", "att", "attributed_touch_time", "attributed_touch_type", "blocked_reason", "blocked_reason_rule", "blocked_reason_value", "blocked_sub_reason", "bundle_id", "campaign", "campaign_type", "carrier", "city", "contributor1_af_prt", "contributor1_campaign", "contributor1_match_type", "contributor1_media_source", "contributor1_touch_time", "contributor1_touch_type", "contributor2_af_prt", "contributor2_campaign", "contributor2_match_type", "contributor2_media_source", "contributor2_touch_time", "contributor2_touch_type", "contributor3_af_prt", "contributor3_campaign", "contributor3_match_type", "contributor3_media_source", "contributor3_touch_time", "contributor3_touch_type", "conversion_type", "country_code", "custom_data", "customer_user_id", "deeplink_url", "device_category", "device_download_time", "device_model", "device_type", "dma", "event_name", "event_revenue", "event_revenue_currency", "event_revenue_usd", "event_source", "event_time", "event_value", "gp_broadcast_referrer", "gp_click_time", "gp_install_begin", "gp_referrer", "http_referrer", "idfa", "idfv", "imei", "impressions", "install_app_store", "install_time", "ip", "is_lat", "is_primary_attribution", "is_receipt_validated", "is_retargeting", "keyword_id", "keyword_match_type", "language", "match_type", "media_source", "mediation_network", "monetization_network", "network_account_id", "oaid", "operator", "original_url", "os_version", "placement", "platform", "postal_code", "region", "rejected_reason", "rejected_reason_value", "retargeting_conversion_type", "sdk_version", "segment", "state", "store_reinstall", "user_agent", "wifi", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appsflyer_events_default_in_app_events


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_appsflyer_events_default_in_app_events
  
      