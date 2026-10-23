with source as (

    select * from {{ source('bdb', 'supplementary_data') }}

),

renamed as (

    select
        game_id,
        season,
        week,
        game_date,
        game_time_eastern,
        home_team_abbr as home_team,
        visitor_team_abbr as away_team,
        play_id,
        play_description,
        quarter,
        game_clock,
        down,
        yards_to_go,
        possession_team,
        defensive_team,
        yardline_side,
        yardline_number,
        pre_snap_home_score,
        pre_snap_visitor_score,
        play_nullified_by_penalty,
        pass_result,
        pass_length,
        offense_formation,
        receiver_alignment,
        route_of_targeted_receiver,
        play_action,
        dropback_type,
        dropback_distance,
        pass_location_type,
        defenders_in_the_box,
        team_coverage_man_zone,
        team_coverage_type,
        try_to_double(penalty_yards) as penalty_yards,
        pre_penalty_yards_gained,
        yards_gained,
        try_to_double(expected_points) as expected_points,
        expected_points_added,
        pre_snap_home_team_win_probability,
        pre_snap_visitor_team_win_probability,
        try_to_double(home_team_win_probability_added) as home_team_win_probability_added,
        try_to_double(visitor_team_win_probility_added) as visitor_team_win_probability_added
    from source

)

select * from renamed
