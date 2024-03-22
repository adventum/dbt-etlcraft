SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_datetime) AS event_datetime,
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    assumeNotNull(coalesce(lower(if(length(utmSource) > 0, concat(utmSource, ' / ', utmMedium), null)), publisher_name, '')) AS adSourceDirty,
    extract(deeplink_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(deeplink_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(deeplink_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(deeplink_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(deeplink_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    greatest(coalesce(extract(utmCampaign, '__([a-zA-Z0-9]{8})'), ''), coalesce(extract(utmContent, '__([a-zA-Z0-9]{8})'), '')) AS utmHash,
    __emitted_at,
    toLowCardinality('AppDeeplinkStat') AS __link
FROM (
    

        (
            select
                cast('test.incremental_appmetrica_events_default_deeplinks' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("appmetrica_device_id" as String) as "appmetrica_device_id" ,
                    cast("city" as String) as "city" ,
                    cast("deeplink_url_parameters" as String) as "deeplink_url_parameters" ,
                    cast("event_datetime" as String) as "event_datetime" ,
                    cast("google_aid" as String) as "google_aid" ,
                    cast("ios_ifa" as String) as "ios_ifa" ,
                    cast("os_name" as String) as "os_name" ,
                    cast("profile_id" as String) as "profile_id" ,
                    cast("publisher_name" as String) as "publisher_name" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_appmetrica_events_default_deeplinks

            
        )

        )




