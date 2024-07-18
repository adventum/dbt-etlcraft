
  
    
    
        
        insert into test.link_registry_appprofilematching__dbt_tmp ("appmetricaDeviceId", "crmUserId", "cityName", "__emitted_at", "__table_name", "__link", "AppProfileMatchingHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime")
  -- depends_on: test.hash_registry_appprofilematching
SELECT appmetricaDeviceId,crmUserId,cityName,__emitted_at,__table_name,__link,AppProfileMatchingHash,AppMetricaDeviceHash,CrmUserHash,__id,__datetime 
FROM test.hash_registry_appprofilematching
GROUP BY appmetricaDeviceId, crmUserId, cityName, __emitted_at, __table_name, __link, AppProfileMatchingHash, AppMetricaDeviceHash, CrmUserHash, __id, __datetime

  