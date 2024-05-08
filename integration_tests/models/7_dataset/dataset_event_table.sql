-- depends_on: {{ ref('full_datestat') }}
-- depends_on: {{ ref('attr_myfirstfunnel_final_table') }}

{{ etlcraft.create_dataset(
    funnel = 'myfirstfunnel',
    conditions =
    [{
    'pipeline':'datestat', 
    'source': 'yd',
    'account': 'testaccount',
    'preset': 'default'
    },
    {
    'pipeline': 'events', 
    'source': 'appmetrica',
    'account': 'testaccount',
    'preset': 'default'
    },
    {
    'pipeline':'events', 
    'source': 'ym',
    'account': 'testaccount',
    'preset': 'default'
    }
     ]
) }}
