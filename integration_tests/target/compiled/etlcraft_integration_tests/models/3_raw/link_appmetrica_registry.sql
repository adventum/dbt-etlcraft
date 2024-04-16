-- depends_on: test.hash_appmetrica_registry
SELECT appmetricaDeviceId,crmUserId,cityName,__emitted_at,__link,AppProfileMatchingHash,AppMetricaDeviceHash,CrmUserHash,__id,__datetime 
FROM test.hash_appmetrica_registry
GROUP BY appmetricaDeviceId, crmUserId, cityName, __emitted_at, __link, AppProfileMatchingHash, AppMetricaDeviceHash, CrmUserHash, __id, __datetime

