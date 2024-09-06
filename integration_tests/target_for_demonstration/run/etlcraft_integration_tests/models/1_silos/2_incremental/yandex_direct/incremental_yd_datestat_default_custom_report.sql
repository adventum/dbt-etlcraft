
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_951bb9ee_eb7b_44e4_99d3_b44e3e697cd0 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_yd_datestat_default_custom_report


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_yd_datestat_default_custom_report
  
      