

  create view test.hash_appmetrica_registry__dbt_tmp 
  
  as (
    -- depends_on: test.combine_appmetrica_registry
SELECT *,
  assumeNotNull(CASE 
WHEN __link = 'UtmHashRegistry' 
    THEN UtmHashRegistryHash 
WHEN __link = 'AppProfileMatching' 
    THEN AppProfileMatchingHash 

    END) as __id,

  assumeNotNull(CASE 
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

                --toLowCardinality('combine_appmetrica_registry')  as _dbt_source_relation,
                
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toString("utmHash") as utmHash ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link 

            from test.combine_appmetrica_registry
        )

        ) 
    WHERE 
    
        True AND 
        True
    )


-- SETTINGS short_circuit_function_evaluation=force_enable


  )