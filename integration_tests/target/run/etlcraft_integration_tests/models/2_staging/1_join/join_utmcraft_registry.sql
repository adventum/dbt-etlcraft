
  
    
    
        
        insert into test.join_utmcraft_registry__dbt_backup ("utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "__emitted_at", "__table_name", "__link")
  -- depends_on: test.incremental_utmcraft_registry_default_utmresult
SELECT
    utm_hashcode AS utmHash,
    JSONExtractString(data, '4') AS utm_base_url,
    JSONExtractString(data, '5') AS utm_utmSource,
    if(JSONExtractString(data, '6') = 'указать вручную', JSONExtractString(data, '95'), JSONExtractString(data, '6')) AS utm_utmMedium,
    JSONExtractString(data, '9') AS utm_utmCampaign,
    JSONExtractString(data, '97') AS utm_project,
    if(JSONExtractString(data, '7') = 'custom-value-input-field',JSONExtractString(data, 'custom-7'),JSONExtractString(data, '7')) AS utm_utmContent,
    JSONExtractString(data, '66') AS utm_strategy,
    concat(if(JSONExtractString(data, '69') = 'custom-value-input-field',JSONExtractString(data, 'custom-69'),JSONExtractString(data, '69')),
            if(JSONExtractString(data, '69') != '' or JSONExtractString(data, 'custom-69') != '', ';', ''),
           if(JSONExtractString(data, '88') = 'custom-value-input-field',JSONExtractString(data, 'custom-88'),JSONExtractString(data, '88')),
           if(JSONExtractString(data, '88') != '' or JSONExtractString(data, 'custom-88') != '', ';', ''),
           if(JSONExtractString(data, '87') = 'custom-value-input-field',JSONExtractString(data, 'custom-87'),JSONExtractString(data, '87')),
           if(JSONExtractString(data, '87') != '' or JSONExtractString(data, 'custom-87') != '', ';', ''),
           if(JSONExtractString(data, '89') = 'custom-value-input-field',JSONExtractString(data, 'custom-89'),JSONExtractString(data, '89')),
           if(JSONExtractString(data, '89') != '' or JSONExtractString(data, 'custom-89') != '', ';', ''),
           if(JSONExtractString(data, '90') = 'custom-value-input-field',JSONExtractString(data, 'custom-90'),JSONExtractString(data, '90')),
           if(JSONExtractString(data, '90') != '' or JSONExtractString(data, 'custom-90') != '', ';', ''),
           if(JSONExtractString(data, '91') = 'custom-value-input-field',JSONExtractString(data, 'custom-91'),JSONExtractString(data, '91')),
           if(JSONExtractString(data, '91') != '' or JSONExtractString(data, 'custom-91') != '', ';', ''),
           if(JSONExtractString(data, '93') = 'custom-value-input-field',JSONExtractString(data, 'custom-93'),JSONExtractString(data, '93')),
           if(JSONExtractString(data, '93') != '' or JSONExtractString(data, 'custom-93') != '', ';', ''),
           if(JSONExtractString(data, '85') = 'custom-value-input-field',JSONExtractString(data, 'custom-85'),JSONExtractString(data, '85')),
           if(JSONExtractString(data, '85') != '' or JSONExtractString(data, 'custom-85') != '', ';', ''),
           if(JSONExtractString(data, '92') = 'custom-value-input-field',JSONExtractString(data, 'custom-92'),JSONExtractString(data, '92')),
           if(JSONExtractString(data, '92') != '' or JSONExtractString(data, 'custom-92') != '', ';', ''),
           if(JSONExtractString(data, '86') = 'custom-value-input-field',JSONExtractString(data, 'custom-86'),JSONExtractString(data, '86'))) AS utm_audience,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name,
    'UtmHashRegistry' AS __link         
FROM (
    

        (
            select
                cast('test.incremental_utmcraft_registry_default_utmresult' as String) as _dbt_source_relation,

                
                    cast("created_at" as String) as "created_at" ,
                    cast("created_by_id" as String) as "created_by_id" ,
                    cast("data" as String) as "data" ,
                    cast("form_id" as String) as "form_id" ,
                    cast("id" as String) as "id" ,
                    cast("updated_at" as String) as "updated_at" ,
                    cast("updated_by_id" as String) as "updated_by_id" ,
                    cast("utm_hashcode" as String) as "utm_hashcode" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_utmcraft_registry_default_utmresult

            
        )

        )





  