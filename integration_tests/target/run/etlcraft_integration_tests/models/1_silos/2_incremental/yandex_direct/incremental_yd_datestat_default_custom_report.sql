
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_8321cbef_6326_48d2_a58a_4e787ccb0180 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_yd_datestat_default_custom_report

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_yd_datestat_default_custom_report

  
      