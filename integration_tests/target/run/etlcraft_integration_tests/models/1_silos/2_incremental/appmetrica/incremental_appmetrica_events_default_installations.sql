
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_installations__dbt_new_data_257a9f0c_75e4_425f_88c2_849703901296 ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "click_datetime", "click_url_parameters", "google_aid", "install_receive_datetime", "ios_ifa", "is_reinstallation", "os_name", "profile_id", "publisher_name", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_events_default_installations

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
                            toString("click_datetime") as click_datetime ,
                            toString("click_url_parameters") as click_url_parameters ,
                            toString("google_aid") as google_aid ,
                            toString("install_receive_datetime") as install_receive_datetime ,
                            toString("ios_ifa") as ios_ifa ,
                            toString("is_reinstallation") as is_reinstallation ,
                            toString("os_name") as os_name ,
                            toString("profile_id") as profile_id ,
                            toString("publisher_name") as publisher_name ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_appmetrica_events_default_installations
        )

        )

  
      