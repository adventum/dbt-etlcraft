
        
  
    
    
        
        insert into test.incremental_yd_default_cmps__dbt_tmp ("__datetime", "__clientName", "__productName", "AdGroupId", "AdGroupName", "CampaignId", "CampaignName", "CampaignType", "Clicks", "Cost", "Impressions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_yd_default_cmps

  
    