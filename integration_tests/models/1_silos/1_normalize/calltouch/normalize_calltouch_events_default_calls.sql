{{ etlcraft.normalize(fields = ['ip', 'os', 'dcm', 'ref', 'url', 'city', 'date', 'attrs', 'order', 'callId', 'device', 'medium', 'orders', 
    'siteId', 'source', 'browser', 'callUrl', 'keyword', 'manager', 'phrases', 'utmTerm', 'clientId', 'duration', 'hostname',
    'siteName', 'callphase', 'mapVisits', 'sessionId', 'sipCallId', 'timestamp', 'userAgent', 'utmMedium', 'utmSource', 
    'ctCallerId', 'ctClientId', 'ctGlobalId', 'successful', 'targetCall', 'uniqueCall', 'utmContent', 'yaClientId', 'attribution',
    'phoneNumber', 'sessionDate', 'subPoolName', 'utmCampaign', 'callbackCall', 'callbackInfo', 'callerNumber', 'phonesInText',
    'yandexDirect', 'googleAdWords', 'statusDetails', 'additionalTags', 'redirectNumber', 'uniqTargetCall', 'waitingConnect',
    'callReferenceId', 'callClientUniqueId'], incremental_datetime_field='date'
    ) }}