
  
    
    
        
        insert into test.hash_utmcraft_registry__dbt_backup ("utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "__emitted_at", "__table_name", "crmUserId", "appmetricaDeviceId", "__link", "UtmHashRegistryHash", "AppProfileMatchingHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime")
  -- depends_on: test.combine_utmcraft_registry
SELECT *,
  assumeNotNull(CASE 
WHEN __link = 'UtmHashRegistry' 
    THEN UtmHashRegistryHash 
WHEN __link = 'AppProfileMatching' 
    THEN AppProfileMatchingHash 

    END) as __id
  , assumeNotNull(CASE 
WHEN __link = 'UtmHashRegistry' 
        THEN toDateTime(toDateTime(0))
    







WHEN __link = 'AppProfileMatching' 
        THEN toDateTime(toDateTime(0))
    

    END) as __datetime

FROM (

SELECT 
    *, 
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(toDateTime(0)))), ''), '') = '', null, hex(MD5('UtmHashRegistry' || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(toDateTime(0)))), ''), '')))))) as UtmHashRegistryHash,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(toDateTime(0)))), ''), '') = '', null, hex(MD5('AppProfileMatching' || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(toDateTime(0)))), ''), '')))))) as AppProfileMatchingHash
    ,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashHash

,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '')))))) as AppMetricaDeviceHash

,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '')))))) as CrmUserHash


    
FROM (

        (
            select
                            toString("utmHash") as utmHash ,
                            toString("utm_base_url") as utm_base_url ,
                            toString("utm_utmSource") as utm_utmSource ,
                            toString("utm_utmMedium") as utm_utmMedium ,
                            toString("utm_utmCampaign") as utm_utmCampaign ,
                            toString("utm_project") as utm_project ,
                            toString("utm_utmContent") as utm_utmContent ,
                            toString("utm_strategy") as utm_strategy ,
                            toString("utm_audience") as utm_audience ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("crmUserId") as crmUserId ,
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("__link") as __link 

            from test.combine_utmcraft_registry
        )

        ) 
    WHERE 
    
        True AND 
        True
    )

-- SETTINGS short_circuit_function_evaluation=force_enable


  