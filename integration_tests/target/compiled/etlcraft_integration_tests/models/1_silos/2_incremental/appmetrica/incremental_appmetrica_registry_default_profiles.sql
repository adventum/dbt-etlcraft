

SELECT *
FROM (

        (
            select
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("appmetrica_device_id") as appmetrica_device_id ,
                            toString("city") as city ,
                            toString("profile_id") as profile_id ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_appmetrica_registry_default_profiles
        )

        )
