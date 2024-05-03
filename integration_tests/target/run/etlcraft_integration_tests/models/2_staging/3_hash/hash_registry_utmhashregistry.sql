
  
    
    
        
        insert into test.hash_registry_utmhashregistry__dbt_backup ("utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "__emitted_at", "__table_name", "__link", "UtmHashRegistryHash", "UtmHashHash", "__id", "__datetime")
  -- depends_on: test.combine_registry_utmhashregistry
SELECT *,
  assumeNotNull(CASE 
WHEN __link = 'UtmHashRegistry' 
    THEN UtmHashRegistryHash 

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
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(toDateTime(0)))), ''), '') = '', null, hex(MD5('UtmHashRegistry' || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(toDateTime(0)))), ''), '')))))) as UtmHashRegistryHash
    ,
    
        
        assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashHash


    
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
                            toString("__link") as __link 

            from test.combine_registry_utmhashregistry
        )

        ) 
    WHERE 
    
        True
    )

-- SETTINGS short_circuit_function_evaluation=force_enable


  