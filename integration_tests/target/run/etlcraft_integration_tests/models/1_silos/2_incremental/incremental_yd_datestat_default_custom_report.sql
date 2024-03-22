
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_tmp ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_yd_datestat_default_custom_report


--disable_incremental=true
  
    