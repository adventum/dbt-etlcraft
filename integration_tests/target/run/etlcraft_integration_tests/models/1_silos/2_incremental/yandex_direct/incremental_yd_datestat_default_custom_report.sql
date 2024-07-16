
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_bb55514f_537c_4384_a7d2_a467a955ab1f ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_yd_datestat_default_custom_report


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_yd_datestat_default_custom_report
  
      