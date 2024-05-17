-- depends_on: test.normalize_mt_registry_default_campaigns


SELECT *
FROM (

        (
            select
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("id") as id ,
                            toString("name") as name ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_mt_registry_default_campaigns
        )

        )
