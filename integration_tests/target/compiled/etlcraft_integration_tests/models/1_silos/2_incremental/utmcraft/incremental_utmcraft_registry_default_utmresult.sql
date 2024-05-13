

SELECT *
FROM (

        (
            select
                            toString("created_at") as created_at ,
                            toString("created_by_id") as created_by_id ,
                            toString("data") as data ,
                            toString("form_id") as form_id ,
                            toString("id") as id ,
                            toString("updated_at") as updated_at ,
                            toString("updated_by_id") as updated_by_id ,
                            toString("utm_hashcode") as utm_hashcode ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_utmcraft_registry_default_utmresult
        )

        )
