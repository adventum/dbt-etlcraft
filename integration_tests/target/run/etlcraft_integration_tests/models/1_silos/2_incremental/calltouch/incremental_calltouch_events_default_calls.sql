
        
  
    
    
        
        insert into test.incremental_calltouch_events_default_calls__dbt_tmp ("__date", "additionalTags", "attribution", "attrs", "browser", "callbackCall", "callbackInfo", "callClientUniqueId", "callerNumber", "callId", "callphase", "callReferenceId", "callUrl", "city", "clientId", "ctCallerId", "ctClientId", "ctGlobalId", "date", "dcm", "device", "duration", "googleAdWords", "hostname", "ip", "keyword", "manager", "mapVisits", "medium", "order", "orders", "os", "phoneNumber", "phonesInText", "phrases", "redirectNumber", "ref", "sessionDate", "sessionId", "sipCallId", "siteId", "siteName", "source", "statusDetails", "subPoolName", "successful", "targetCall", "timestamp", "uniqTargetCall", "uniqueCall", "url", "userAgent", "utmCampaign", "utmContent", "utmMedium", "utmSource", "utmTerm", "waitingConnect", "yaClientId", "yandexDirect", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_calltouch_events_default_calls


    
SELECT * REPLACE(toDate(replaceRegexpOne(replaceRegexpOne(date, '\\s+(\\d):', ' 0\\1:'), '(\\d{2})\\/(\\d{2})\\/(\\d{4})', '\\3-\\2-\\1'), 'UTC') AS __date) 

FROM normalize_calltouch_events_default_calls


  
    