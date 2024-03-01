{%- macro combine_events_default(
    pipeline_name,
    template_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

SELECT  
__date,
event_datetime,
accountName,
__table_name,
appmetricaDeviceId,
mobileAdsId,
crmUserId,
transactionId,
promoCode,
osName,
cityName,
addToCartSessions,
cartViewSessions,
checkoutSessions,
webSalesSessions,
sales,
amountSales,
registrationCardSessions,
registrationButtonClick,
linkingCardToPhoneNumberSessions,
registrationCashbackSessions,
instantDiscountActivationSessions,
couponActivationSessions,
participationInLotterySessions,
screenView,
__emitted_at
FROM {{ ref('join_appmetrica_events_default_events') }}
UNION ALL

SELECT  
__date,
event_datetime,
accountName,
__table_name,
appmetricaDeviceId,
mobileAdsId,
crmUserId,
transactionId,
promoCode,
osName,
cityName,
addToCartSessions,
cartViewSessions,
checkoutSessions,
webSalesSessions,
sales,
amountSales,
registrationCardSessions,
registrationButtonClick,
linkingCardToPhoneNumberSessions,
registrationCashbackSessions,
instantDiscountActivationSessions,
couponActivationSessions,
participationInLotterySessions,
screenView,
__emitted_at
FROM {{ ref('join_appmetrica_events_default_screen_view') }}


{% endmacro %}