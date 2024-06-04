-- depends_on: test.normalize_mt_registry_default_banners


SELECT *
FROM (

        (
            select
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("campaign_id") as campaign_id ,
                            toString("id") as id ,
                            toString("textblocks") as textblocks ,
                            toString("urls") as urls ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_mt_registry_default_banners
        )

        )