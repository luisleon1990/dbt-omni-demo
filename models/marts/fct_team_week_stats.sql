select
    team || '-' || season || '-' || week || '-' || season_type as team_week_key,
    *
from {{ ref('stg_nflverse__team_stats') }}
