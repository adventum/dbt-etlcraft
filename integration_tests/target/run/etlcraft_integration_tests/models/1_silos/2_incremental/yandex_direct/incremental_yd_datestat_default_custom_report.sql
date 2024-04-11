
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_a5ae1888_9257_4a70_8a77_2c262e2d98f6 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_yd_datestat_default_custom_report

  
      