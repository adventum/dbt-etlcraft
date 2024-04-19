
  
    
    
        
        insert into test.link_appmetrica_registry__dbt_backup ("appmetricaDeviceId", "crmUserId", "cityName", "utmHash", "__emitted_at", "__table_name", "__link", "UtmHashRegistryHash", "AppProfileMatchingHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime")
  -- depends_on: test.hash_appmetrica_registry
SELECT appmetricaDeviceId,crmUserId,cityName,utmHash,__emitted_at,__table_name,__link,UtmHashRegistryHash,AppProfileMatchingHash,UtmHashHash,AppMetricaDeviceHash,CrmUserHash,__id,__datetime 
FROM test.hash_appmetrica_registry
GROUP BY appmetricaDeviceId, crmUserId, cityName, utmHash, __emitted_at, __table_name, __link, UtmHashRegistryHash, AppProfileMatchingHash, UtmHashHash, AppMetricaDeviceHash, CrmUserHash, __id, __datetime


  