

  create view test.combine_utmcraft_registry__dbt_tmp 
  
  as (
    -- depends_on: test.join_utmcraft_registry
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

        (
            select

                toLowCardinality('join_utmcraft_registry')  as None,
                
                            toString("utmHash") as utmHash ,
                            toString("utm_base_url") as utm_base_url ,
                            toString("utm_utmSource") as utm_utmSource ,
                            toString("utm_utmMedium") as utm_utmMedium ,
                            toString("utm_utmCampaign") as utm_utmCampaign ,
                            toString("utm_project") as utm_project ,
                            toString("utm_utmContent") as utm_utmContent ,
                            toString("utm_strategy") as utm_strategy ,
                            toString("utm_audience") as utm_audience ,
                            toDateTime("__emitted_at") as __emitted_at 

            from test.join_utmcraft_registry
        )

        )
  )