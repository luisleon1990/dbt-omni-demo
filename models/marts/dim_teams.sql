select
    team_abbr as team_key,
    *
from {{ ref('stg_nflverse__teams') }}
