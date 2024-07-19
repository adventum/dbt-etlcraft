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


FROM test.combine_datestat 
WHERE 

    True
)
-- SETTINGS short_circuit_function_evaluation=force_enable

