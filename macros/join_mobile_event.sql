{% macro join_mobile_event( source_types, streams, templates) %}

{% if source_types == 'appsflyer' %}

    {% for stream in streams %}

        {% if stream == 'in_app_events' %} 

            WITH install as (
                --test query_type
                SELECT 
                    __datetime AS event_time,
                    toDate(__datetime) AS event_date,
                    toDate(attributed_touch_time) AS attributed_touch_date,
                    toDate(install_time) AS install_date,
                    * EXCEPT(__emitted_at, __normalized_at)
                FROM {{ref('incremental_' ~ templates ~ '_' ~ stream)}}
                )

        {% elif stream == 'post_attribution_in_app_events' %}   

            ,post_attribution as (
                SELECT 
                    x.*,
                    y.appsflyer_id = x.appsflyer_id as is_fraud,
                    detection_date,
                    fraud_reason,	
                    fraud_reasons,	
                    fraud_sub_reason
                FROM install as x 
                left join {{ref('incremental_' ~ templates ~ '_' ~ stream)}} as y
                using(appsflyer_id)
                )

        {% endif %}
    {% endfor %}

    {% if "in_app_events" in streams %}
        {% if "post_attribution_in_app_events" in streams %}
            SELECT * FROM post_attribution
        {% else %}
            SELECT * FROM install
        {% endif %}
    {% endif %}

{% endif %}

{% endmacro %}