select
    game_id as game_key,
    *,
    game_type <> 'REG' as is_postseason,
    home_score + away_score as total_points,
    case
        when home_score is null or away_score is null then null
        when home_score > away_score then home_team
        when away_score > home_score then away_team
        else 'TIE'
    end as winning_team
from {{ ref('stg_nflverse__games') }}
