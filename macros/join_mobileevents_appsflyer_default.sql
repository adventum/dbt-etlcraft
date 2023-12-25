{% macro join_mobileevents_appsflyer_default(
    pipeline_name,
    sourcetype_name,
    template_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) %}
WITH in_app_events as (
SELECT
    *EXCEPT(__emitted_at, __normalized_at)
FROM {{ref('incremental_appsflyer_default_in_app_events')}}
{% if date_from and  date_to %} 
    WHERE toDate(__datetime) between '{{date_from}}' and '{{date_to}}'
{% endif %}
)
{% if "incremental_appsflyer_default_post_attribution_in_app_events" in relations_dict %} 
    ,attribution_in_app_events as (
        SELECT 
            appsflyer_id
            ,detection_date
            ,fraud_reason	
            ,fraud_reasons
            ,fraud_sub_reason
        FROM {{ref('incremental_appsflyer_default_post_attribution_in_app_events')}}
        
        {% if date_from and  date_to %} 
            WHERE toDate(__datetime) between '{{date_from}}' and '{{date_to}}'
        {% endif %}
    )
    ,events_join as (
        SELECT 
            x.*
            ,y.appsflyer_id = x.appsflyer_id as is_fraud
            ,detection_date
            ,fraud_reason	
            ,fraud_reasons
            ,fraud_sub_reason
        FROM in_app_events as x
        LEFT JOIN attribution_in_app_events as y
        using(appsflyer_id)
    )

    SELECT * FROM events_join
{% else %}
    SELECT * FROM in_app_events
{% endif %}



{% endmacro %}