
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
                            toString("deeplink_url_parameters") as deeplink_url_parameters ,
                            toString("event_receive_datetime") as event_receive_datetime ,
                            toString("google_aid") as google_aid ,
                            toString("ios_ifa") as ios_ifa ,
                            toString("os_name") as os_name ,
                            toString("profile_id") as profile_id ,
                            toString("publisher_name") as publisher_name ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_appmetrica_events_default_deeplinks
        )

        )
