{%- macro join_appmetrica_events_default_profiles(
    sourcetype_name,
    pipeline_name,
    template_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

SELECT
    appmetrica_device_id AS appmetricaDeviceId,
    profile_id AS crmUserId,
    mp_card_number AS mpCardNumber,
    city_code AS cityCode,
    __emitted_at
    
FROM {{ ref('incremental_appmetrica_events_default_profiles') }}

{% endmacro %}