
        
  
    
    
        
        insert into test.hash_datestat__dbt_new_data_f6e8ee16_f9a8_4fbb_be99_0c523e494e40 ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "adCampaignName", "adId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adText", "adCost", "impressions", "clicks", "__emitted_at", "__link", "adGroupName", "adPhraseId", "AdCostStatHash", "UtmHashHash", "__id", "__datetime")
  -- depends_on: test.combine_datestat
SELECT *,
  assumeNotNull(CASE  
    WHEN __link = 'AdCostStat' 
    THEN AdCostStatHash 

    END) as __id
  , assumeNotNull(CASE
    WHEN __link = 'AdCostStat' 
    
    THEN toDateTime(__date) 
    END) AS __datetime
FROM (

SELECT *, 
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ifnull(nullif(upper(trim(toString(adCampaignName))), ''), '') || ifnull(nullif(upper(trim(toString(adGroupName))), ''), '') || ifnull(nullif(upper(trim(toString(adId))), ''), '') || ifnull(nullif(upper(trim(toString(adPhraseId))), ''), '') || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(reportType))), ''), '') = '', null, hex(MD5('AdCostStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adCampaignName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adGroupName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adPhraseId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(reportType))), ''), '')))))) as AdCostStatHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashHash


FROM (

(
SELECT
        toDate("__date") as __date ,
        toString("reportType") as reportType ,
        toString("accountName") as accountName ,
        toString("__table_name") as __table_name ,
        toString("adSourceDirty") as adSourceDirty ,
        toString("adCampaignName") as adCampaignName ,
        toString("adId") as adId ,
        toString("utmSource") as utmSource ,
        toString("utmMedium") as utmMedium ,
        toString("utmCampaign") as utmCampaign ,
        toString("utmTerm") as utmTerm ,
        toString("utmContent") as utmContent ,
        toString("utmHash") as utmHash ,
        toString("adTitle1") as adTitle1 ,
        toString("adText") as adText ,
        toFloat64("adCost") as adCost ,
        toInt32("impressions") as impressions ,
        toInt32("clicks") as clicks ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__link") as __link ,
        toString("adGroupName") as adGroupName ,
        toString("adPhraseId") as adPhraseId 
FROM test.combine_datestat
)

) 
WHERE 

    True
)

-- SETTINGS short_circuit_function_evaluation=force_enable


  
      