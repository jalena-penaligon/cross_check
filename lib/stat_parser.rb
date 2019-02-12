class StatParser
  attr_reader :merged_data
  def initialize(array_raw_data, array_merge_keys)
    @merged_data = merge_data(array_raw_data, array_merge_keys)
  end

  def merge_data(array_raw_data, array_merge_keys)
    ### array_raw_data is three arrays of hashes
    ### 1st hash is of game_team data
    ### 2nd hash is of  game data
    ### 3rd hash is team_info data

    ### array_merge_keys is two keys -- :game_id, :team_id

    ### game_team and game are merged with :game_id
    ### game/game_team and team_info are merged with :team_id

    ### Desired keys are:
    # {game_id, team_id, hoa, won, settled_in, head_coach,
    #  goals, shots, hits, pim, powerplaygoals, powerplayopportunities,
    #  faceoffwinpercentage, giveaways, takeaways, teamname, season,
    #  type, date_time, venue_time_zone_tz}

  end
end
