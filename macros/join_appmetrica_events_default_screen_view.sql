{%- macro join_appmetrica_events_default_screen_view(
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
    toDateTime(date_add(hour, 23, date_add(minute, 59, toDateTime(__date)))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_datetime) AS event_datetime, 
    accountName,
    appmetricaDeviceId,
    mobileAdsId,
    crmUserId,    
    '' AS transactionId,
    '' AS promoCode,
    osName,
    cityName,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,    
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    screen_view AS screenView,
    __emitted_at
FROM {{ ref('incremental_appmetrica_events_default_screen_view') }}

{% endmacro %}