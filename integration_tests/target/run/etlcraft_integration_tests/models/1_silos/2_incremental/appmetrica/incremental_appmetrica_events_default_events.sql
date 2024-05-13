
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_events__dbt_tmp ("__date", "__clientName", "__productName", "app_version_name", "appmetrica_device_id", "city", "event_json", "event_name", "event_receive_datetime", "google_aid", "installation_id", "ios_ifa", "os_name", "profile_id", "session_id", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("app_version_name") as app_version_name ,
                            toString("appmetrica_device_id") as appmetrica_device_id ,
                            toString("city") as city ,
                            toString("event_json") as event_json ,
                            toString("event_name") as event_name ,
                            toString("event_receive_datetime") as event_receive_datetime ,
                            toString("google_aid") as google_aid ,
                            toString("installation_id") as installation_id ,
                            toString("ios_ifa") as ios_ifa ,
                            toString("os_name") as os_name ,
                            toString("profile_id") as profile_id ,
                            toString("session_id") as session_id ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_appmetrica_events_default_events
        )

        )

  
    