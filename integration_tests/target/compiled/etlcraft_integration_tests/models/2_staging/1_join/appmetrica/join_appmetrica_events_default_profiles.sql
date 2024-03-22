SELECT
    appmetrica_device_id AS appmetricaDeviceId,
    profile_id AS crmUserId,
    mp_card_number AS mpCardNumber,
    city_code AS cityCode,
    __emitted_at
    
FROM test.incremental_appmetrica_events_default_profiles




