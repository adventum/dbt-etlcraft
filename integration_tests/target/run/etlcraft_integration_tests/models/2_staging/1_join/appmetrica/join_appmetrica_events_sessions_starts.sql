
        
  
    
    
        
        insert into test.join_appmetrica_events_sessions_starts ("__date", "__table_name", "event_datetime", "accountName", "installationDeviceId", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "osName", "cityName", "sessions", "__emitted_at", "__link")
  SELECT
    toDateTime(date_add(minute, 1, toDateTime(__date))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(session_start_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    --session_id AS appSessionId, --таких данных сейчас нет
    CONCAT(installation_id, appmetrica_device_id) AS installationDeviceId,
    appmetrica_device_id AS appmetricaDeviceId,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    1 AS sessions,
    __emitted_at,
    toLowCardinality('AppSessionStat') AS __link 
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_sessions_starts' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("google_aid" as String) as "google_aid" ,
                    cast("installation_id" as String) as "installation_id" ,
                    cast("ios_ifa" as String) as "ios_ifa" ,
                    cast("os_name" as String) as "os_name" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("session_start_datetime" as String) as "session_start_datetime" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_events_default_sessions_starts

            
        )

        )





  
    