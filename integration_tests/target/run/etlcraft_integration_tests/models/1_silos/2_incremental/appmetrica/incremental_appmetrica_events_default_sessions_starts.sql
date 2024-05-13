
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_sessions_starts__dbt_tmp ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "google_aid", "installation_id", "ios_ifa", "os_name", "profile_id", "session_start_receive_datetime", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("appmetrica_device_id") as appmetrica_device_id ,
                            toString("city") as city ,
                            toString("google_aid") as google_aid ,
                            toString("installation_id") as installation_id ,
                            toString("ios_ifa") as ios_ifa ,
                            toString("os_name") as os_name ,
                            toString("profile_id") as profile_id ,
                            toString("session_start_receive_datetime") as session_start_receive_datetime ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_appmetrica_events_default_sessions_starts
        )

        )

  
    