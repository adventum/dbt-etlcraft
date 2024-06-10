{%- macro join_appmetrica_events(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}
{%- if execute -%}
{#- задаём общие части имени -#}
{%- set sourcetype_name = 'appmetrica' -%}
{%- set pipeline_name = 'events' -%}  {# это общее для всех стримов #}

{#- для каждого стрима собираем инкрементал-таблицы и создаём свой source_table_<...> -#}
{%- set table_pattern_deeplinks = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'deeplinks' ~ '$' -%}
{%- set relations_deeplinks = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_deeplinks) -%}   
{%- if not relations_deeplinks -%} 
    {{ exceptions.raise_compiler_error('No relations_deeplinks. 
    No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_deeplinks"') }}
{%- endif -%}
{%- set source_table_deeplinks = '(' ~ dbt_utils.union_relations(relations_deeplinks) ~ ')' -%}    
{%- if not source_table_deeplinks -%} 
    {{ exceptions.raise_compiler_error('No source_table_deeplinks.
    Macro dbt_utils.union_relations fetches no data from relations_deeplinks') }}
{%- endif -%}

{%- set table_pattern_events = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'events' ~ '$' -%}
{%- set relations_events = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_events) -%}   
{%- if not relations_events -%} 
    {{ exceptions.raise_compiler_error('No relations_events.
    No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_events"') }}
{%- endif -%}
{%- set source_table_events = '(' ~ dbt_utils.union_relations(relations_events) ~ ')' -%}  
{%- if not source_table_events -%} 
    {{ exceptions.raise_compiler_error('No source_table_events.
    Macro dbt_utils.union_relations fetches no data from relations_events') }}
{%- endif -%}

{%- set table_pattern_install = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'installations' ~ '$' -%}
{%- set relations_install = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_install) -%}   
  {%- if not relations_install -%} 
        {{ exceptions.raise_compiler_error('No relations_install.
        No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_installations"') }}
  {%- endif -%}
{%- set source_table_install = '(' ~ dbt_utils.union_relations(relations_install) ~ ')' -%} 
  {%- if not source_table_install -%} 
        {{ exceptions.raise_compiler_error('No source_table_install.
        Macro dbt_utils.union_relations fetches no data from relations_install') }}
  {%- endif -%}

{%- set table_pattern_screen_view = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'screen_view' ~ '$' -%}
{%- set relations_screen_view = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_screen_view) -%}   
  {%- if not relations_screen_view -%} 
        {{ exceptions.raise_compiler_error('No relations_screen_view.
        No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_screen_view"') }}
  {%- endif -%}
{%- set source_table_screen_view = '(' ~ dbt_utils.union_relations(relations_screen_view) ~ ')' -%} 
  {%- if not source_table_screen_view -%} 
        {{ exceptions.raise_compiler_error('No source_table_screen_view.
        Macro dbt_utils.union_relations fetches no data from relations_screen_view') }}
  {%- endif -%}

{%- set table_pattern_sessions_starts = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'sessions_starts' ~ '$' -%}
{%- set relations_sessions_starts = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_sessions_starts) -%}   
  {%- if not relations_sessions_starts -%} 
        {{ exceptions.raise_compiler_error('No relations_sessions_starts.
        No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_sessions_starts"') }}
  {%- endif -%}
{%- set source_table_sessions_starts = '(' ~ dbt_utils.union_relations(relations_sessions_starts) ~ ')' -%} 
  {%- if not source_table_sessions_starts -%} 
        {{ exceptions.raise_compiler_error('No source_table_sessions_starts.
        Macro dbt_utils.union_relations fetches no data from relations_sessions_starts') }}
  {%- endif -%}


{#- для каждого стрима создаём его CTE с одинаковым набором полей и их расположением -#}
{#- первый стрим - deeplinks -#}
WITH join_appmetrica_events_deeplinks AS (
SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_receive_datetime) AS event_datetime,
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    '' AS promoCode, --
    os_name AS osName,
    city AS cityName,
    assumeNotNull(coalesce({{ etlcraft.get_adsourcedirty() }}, publisher_name, '')) AS adSourceDirty,
    extract(deeplink_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(deeplink_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(deeplink_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(deeplink_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(deeplink_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    '' AS transactionId,
    {{ etlcraft.get_utmhash('__', ['utmCampaign', 'utmContent']) }} AS utmHash,
    0 AS sessions, --
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    0 AS installApp,
    0 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppDeeplinkStat') AS __link
FROM {{ source_table_deeplinks }}
)

{#- подготовка в несколько шагов ко второму стриму -#}
, union_events AS (
SELECT
    __emitted_at,
    splitByChar('_', __table_name)[6] AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    city AS cityName,
    event_name AS eventName,
    event_json AS eventJson,
    session_id AS sessionId,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    JSONExtractString(event_json, 'transaction_id') AS transactionId,
    appmetrica_device_id AS appmetricaDeviceId,
    os_name AS osName,
    profile_id AS crmUserId,
    JSONExtractString(event_json, 'coupon') AS promoCode,    
    toDate(__date) AS __date, 
    toDateTime(event_receive_datetime) AS event_datetime, 
    0 AS screen_view
FROM {{ source_table_events }}
)
, join_appmetrica_events_prepare AS (
SELECT 
    __date,
    toLowCardinality(__table_name) AS __table_name,
    event_datetime,
    toLowCardinality(accountName) AS accountName,
    appmetricaDeviceId,
    mobileAdsId,
    crmUserId,   
    promoCode,
    osName,
    cityName,
    '' AS adSourceDirty,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    transactionId,
    '' AS UtmHash,
    0 AS sessions,
    eventName = 'add_to_cart' AS addToCartSessions,
    eventName = 'view_cart' AS cartViewSessions,
    eventName = 'begin_checkout' AS checkoutSessions,
    eventName = 'purchase' AS webSalesSessions,
    eventName = 'purchase' AS sales,    
    assumeNotNull(coalesce(if(eventName = 'purchase', toFloat64(nullif(JSONExtractString(JSONExtractString(JSONExtractString(eventJson, 'value'), 'fiat'), 'value'), '')), 0), 0)) AS amountSales,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'BindVirtualCard' AND  JSONExtractString(eventJson, 'item_name') = 'Auth' AS registrationCardSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'IntroRegistrationButtonClick' AND (JSONExtractString(eventJson, 'item_name') = 'AdventCalendar' or JSONExtractString(eventJson, 'item_name') = 'ScratchCards') as registrationButtonClick,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'BindPlasticCard' AND  JSONExtractString(eventJson, 'item_name') = 'Auth' AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CashbackButtonRegistration' AND  JSONExtractString(eventJson, 'item_name') = 'Cashback' AS registrationCashbackSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'ButtonActivate' AS instantDiscountActivationSessions,
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponListActivateCoupon' AND  JSONExtractString(eventJson, 'item_name') = 'Coupons') OR
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponDetailActivate' AND  JSONExtractString(eventJson, 'item_name') = 'Coupons') OR 
    (eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'CouponListActivateCoupon' AND  JSONExtractString(eventJson, 'item_name') = 'Club') AS couponActivationSessions,
    eventName = 'select_content' AND  JSONExtractString(eventJson, 'item_category') = 'TakePartButton' AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    0 AS installApp,
    0 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppEventStat') AS __link,
    JSONExtractString(eventJson, 'item_category') AS __itemCategory, 
    JSONExtractString(eventJson, 'item_name') AS __itemName,
    row_number() over() AS __rn,
    eventName AS __eventName, 
    sessionId AS __sessionId
FROM union_events
WHERE addToCartSessions > 0 OR cartViewSessions > 0 OR checkoutSessions > 0 OR registrationButtonClick > 0
  OR webSalesSessions > 0  OR sales > 0 OR amountSales > 0 
  OR registrationCardSessions > 0 OR linkingCardToPhoneNumberSessions > 0 
  OR registrationCashbackSessions > 0 OR instantDiscountActivationSessions > 0 
  OR couponActivationSessions > 0 OR participationInLotterySessions > 0 or screenView > 0
ORDER BY __date
)
, min_event AS (
SELECT MIN(__rn) AS __rn 
FROM join_appmetrica_events_prepare
GROUP BY appmetricaDeviceId, __sessionId, __eventName, __itemCategory, __itemName
)

{#- второй стрим - events -#}
, join_appmetrica_events_events AS (
SELECT * EXCEPT(__itemCategory, __itemName, __rn, __eventName, __sessionId)
FROM join_appmetrica_events_prepare
WHERE __rn IN (SELECT __rn FROM min_event) AND  
    (addToCartSessions > 0 OR cartViewSessions > 0 OR checkoutSessions > 0 
    OR webSalesSessions > 0  OR sales > 0 OR amountSales > 0 
    OR registrationCardSessions > 0 OR linkingCardToPhoneNumberSessions > 0 
    OR registrationCashbackSessions > 0 OR instantDiscountActivationSessions > 0 OR registrationButtonClick > 0
    OR couponActivationSessions > 0 OR participationInLotterySessions > 0)
)

{#- третий стрим - install -#}
, join_appmetrica_events_install AS (
SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(install_receive_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    '' AS promoCode,
    os_name AS osName,
    city AS cityName,
    if(match(click_url_parameters, 'organic'), 'Органическая установка', assumeNotNull(coalesce({{ etlcraft.get_adsourcedirty() }}, publisher_name, ''))) AS adSourceDirty,
    extract(click_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(click_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(click_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(click_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(click_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    '' AS transactionId,
    {{ etlcraft.get_utmhash('__', ['utmContent', 'utmCampaign']) }} AS utmHash,
    0 AS sessions,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    is_reinstallation = 'false' AS installApp,
    1 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppInstallStat') AS __link
FROM {{ source_table_install }}
)

{#- четвёртый стрим - screen_view -#}
, join_appmetrica_events_screen_view AS (
SELECT
    toDateTime(date_add(hour, 23, date_add(minute, 59, toDateTime(__date)))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_receive_datetime) AS event_datetime, 
    accountName,
    appmetricaDeviceId,
    mobileAdsId,
    crmUserId, 
    '' AS promoCode,
    osName,
    cityName,
    '' AS adSourceDirty,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    '' AS transactionId,
    '' AS utmHash,
    0 AS sessions,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,    
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    screen_view AS screenView,
    0 AS installApp,
    0 AS installs,
    '' AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppEventStat') AS __link 
FROM {{ source_table_screen_view }}
)

{#- пятый стрим - sessions_starts -#}
, join_appmetrica_events_sessions_starts AS (
SELECT
    toDateTime(date_add(minute, 1, toDateTime(__date))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(session_start_receive_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    profile_id AS crmUserId,
    '' AS promoCode,
    os_name AS osName,
    city AS cityName,
    '' AS adSourceDirty,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    '' AS transactionId,
    '' AS UtmHash,
    1 AS sessions,
    0 AS addToCartSessions,
    0 AS cartViewSessions,
    0 AS checkoutSessions,
    0 AS webSalesSessions,
    0 AS sales,
    0 AS amountSales,
    0 AS registrationCardSessions,
    0 AS registrationButtonClick,
    0 AS linkingCardToPhoneNumberSessions,
    0 AS registrationLendingPromotionsSessions,
    0 AS registrationCashbackSessions,
    0 AS instantDiscountActivationSessions,
    0 AS couponActivationSessions,
    0 AS participationInLotterySessions,
    0 AS pagesViews,
    0 AS screenView,
    0 AS installApp,
    0 AS installs,
    CONCAT(installation_id, appmetrica_device_id) AS installationDeviceId,
    __emitted_at,
    toLowCardinality('AppSessionStat') AS __link 
FROM {{ source_table_sessions_starts }}
)

{#- теперь делаем  UNION записанных ранее CTE -#}

SELECT * 
FROM join_appmetrica_events_deeplinks
UNION ALL
SELECT * 
FROM join_appmetrica_events_events
UNION ALL
SELECT * 
FROM join_appmetrica_events_install
UNION ALL
SELECT * 
FROM join_appmetrica_events_screen_view
UNION ALL
SELECT * 
FROM join_appmetrica_events_sessions_starts

{%- endif -%}
{% endmacro %}