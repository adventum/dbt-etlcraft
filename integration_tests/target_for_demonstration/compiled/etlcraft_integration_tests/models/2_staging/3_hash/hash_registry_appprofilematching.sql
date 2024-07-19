-- depends_on: test.combine_registry_appprofilematching
SELECT *,
  assumeNotNull(CASE  
    WHEN __link = 'AppProfileMatching' 
    THEN AppProfileMatchingHash 

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
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') = '', null, hex(MD5('AppProfileMatching' || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '')))))) as AppProfileMatchingHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '')))))) as AppMetricaDeviceHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '')))))) as CrmUserHash


FROM test.combine_registry_appprofilematching 
WHERE 

    True
)
-- SETTINGS short_circuit_function_evaluation=force_enable

