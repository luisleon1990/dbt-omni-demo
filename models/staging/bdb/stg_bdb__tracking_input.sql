with source as (

    select * from {{ source('bdb', 'tracking_input') }}

),

renamed as (

    select
        game_id,
        play_id,
        nfl_id,
        frame_id,
        player_to_predict,
        play_direction,
        absolute_yardline_number,
        player_name,
        player_height,
        player_weight,
        player_birth_date,
        player_position,
        player_side,
        player_role,
        x,
        y,
        s as speed,
        a as acceleration,
        dir as direction,
        o as orientation,
        num_frames_output,
        ball_land_x,
        ball_land_y
    from source

)

select * from renamed
