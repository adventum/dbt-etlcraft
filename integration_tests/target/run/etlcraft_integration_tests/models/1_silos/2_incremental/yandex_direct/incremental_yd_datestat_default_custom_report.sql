
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_d00f206f_3a10_4cf3_beb1_b14662f886e4 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_yd_datestat_default_custom_report


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_yd_datestat_default_custom_report
  
      