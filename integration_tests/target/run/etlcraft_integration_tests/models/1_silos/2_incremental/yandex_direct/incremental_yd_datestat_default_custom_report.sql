
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_1cd4b8c7_8e41_46eb_99e7_70d0e345ce42 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_yd_datestat_default_custom_report

  
      