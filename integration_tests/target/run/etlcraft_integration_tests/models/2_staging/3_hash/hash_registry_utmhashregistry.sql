
  
    
    
        
        insert into test.hash_registry_utmhashregistry__dbt_tmp ("utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "__emitted_at", "__table_name", "__link", "UtmHashRegistryHash", "UtmHashHash", "__id", "__datetime")
  -- depends_on: test.combine_registry_utmhashregistry
SELECT *,
  assumeNotNull(CASE  
    WHEN __link = 'UtmHashRegistry' 
    THEN UtmHashRegistryHash 

    END) as __id
  , assumeNotNull(CASE
    WHEN __link = 'UtmHashRegistry' 
    
    THEN toDateTime(
    0) 
    
    WHEN __link = 'AppProfileMatching' 
    
    THEN toDateTime(
    0) 
    END) AS __datetime
FROM (

SELECT *, 
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5('UtmHashRegistry' || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashRegistryHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashHash


FROM test.combine_registry_utmhashregistry 
WHERE 

    True
)
-- SETTINGS short_circuit_function_evaluation=force_enable


  