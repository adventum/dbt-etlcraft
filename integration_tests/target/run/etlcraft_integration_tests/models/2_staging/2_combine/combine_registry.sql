

  create view test.combine_registry__dbt_tmp 
  
  as (
    -- depends_on: test.join_appmetrica_registry_app_profile_matching
-- depends_on: test.join_utmcraft_registry
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

        (
            select

                toLowCardinality('join_appmetrica_registry_app_profile_matching')  as None,
                
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link ,
                            toString('') as utmHash ,
                            toString('') as utm_base_url ,
                            toString('') as utm_utmSource ,
                            toString('') as utm_utmMedium ,
                            toString('') as utm_utmCampaign ,
                            toString('') as utm_project ,
                            toString('') as utm_utmContent ,
                            toString('') as utm_strategy ,
                            toString('') as utm_audience 

            from test.join_appmetrica_registry_app_profile_matching
        )

        union all
        

        (
            select

                toLowCardinality('join_utmcraft_registry')  as None,
                
                            toString('') as appmetricaDeviceId ,
                            toString('') as crmUserId ,
                            toString('') as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString('') as __link ,
                            toString("utmHash") as utmHash ,
                            toString("utm_base_url") as utm_base_url ,
                            toString("utm_utmSource") as utm_utmSource ,
                            toString("utm_utmMedium") as utm_utmMedium ,
                            toString("utm_utmCampaign") as utm_utmCampaign ,
                            toString("utm_project") as utm_project ,
                            toString("utm_utmContent") as utm_utmContent ,
                            toString("utm_strategy") as utm_strategy ,
                            toString("utm_audience") as utm_audience 

            from test.join_utmcraft_registry
        )

        )
  )