
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_f6e8ee16_f9a8_4fbb_be99_0c523e494e40 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_yd_datestat_default_custom_report

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_yd_datestat_default_custom_report

  
      