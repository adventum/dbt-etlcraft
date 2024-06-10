
        
  
    
    
        
        insert into test.incremental_yd_datestat_default_custom_report__dbt_new_data_e73065dd_cb2b_48cf_898d_f49bff11cfc3 ("__date", "__clientName", "__productName", "AdId", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Date", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_yd_datestat_default_custom_report

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_yd_datestat_default_custom_report

  
      