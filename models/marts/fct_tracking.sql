{{
    config(
        materialized='incremental',
        unique_key='tracking_key',
        incremental_strategy='merge'
    )
}}

-- One row per player per frame. pre_throw frames come from the tracking input and carry
-- motion and play context; in_air frames come from the tracking output and carry position only.

with pre_throw as (

    select
        game_id || '-' || play_id || '-' || nfl_id || '-pre_throw-' || frame_id as tracking_key,
        game_id,
        play_id,
        nfl_id,
        'pre_throw' as tracking_phase,
        frame_id,
        x,
        y,
        speed,
        acceleration,
        direction,
        orientation,
        player_to_predict,
        player_role,
        player_side,
        player_position,
        play_direction,
        absolute_yardline_number,
        num_frames_output,
        ball_land_x,
        ball_land_y
    from {{ ref('stg_bdb__tracking_input') }}
    {% if is_incremental() %}
    where game_id >= (select max(game_id) from {{ this }})
    {% endif %}

),

in_air as (

    select
        game_id || '-' || play_id || '-' || nfl_id || '-in_air-' || frame_id as tracking_key,
        game_id,
        play_id,
        nfl_id,
        'in_air' as tracking_phase,
        frame_id,
        x,
        y,
        null::float as speed,
        null::float as acceleration,
        null::float as direction,
        null::float as orientation,
        null::boolean as player_to_predict,
        null::varchar as player_role,
        null::varchar as player_side,
        null::varchar as player_position,
        null::varchar as play_direction,
        null::number as absolute_yardline_number,
        null::number as num_frames_output,
        null::float as ball_land_x,
        null::float as ball_land_y
    from {{ ref('stg_bdb__tracking_output') }}
    {% if is_incremental() %}
    where game_id >= (select max(game_id) from {{ this }})
    {% endif %}

)

select * from pre_throw
union all
select * from in_air
