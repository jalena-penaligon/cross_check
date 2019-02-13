require 'pry'
class StatParser
  attr_reader :merged_data
  def initialize(array_raw_data, array_merge_keys)
    @merged_data = merge_data(array_raw_data, array_merge_keys)
  end

  def merge_data(array_raw_data, array_merge_keys)
    #game_team = array_raw_data[0]
    #game_data = array_raw_data[1]
    #team_info = array_raw_data[2]

    first_merge = merge_hash_arrays(array_raw_data[0], array_raw_data[1], :game_id)


    second_merge = merge_hash_arrays(first_merge, array_raw_data[2], :team_id)

    return second_merge
  end

  def merge_hash_arrays(merge_to_array, merge_from_array, merge_key)
    merge_to_array.map do |hash_to_merge|
      to_merge = find_hash_to_merge(hash_to_merge, merge_from_array, merge_key)
     hash_to_merge.merge(to_merge)
    end
  end

  def find_hash_to_merge(hash_to_merge, merge_from_array, merge_key)
    merge_from_array.find do |merge_from_hash|
      merge_from_hash[merge_key] == hash_to_merge[merge_key]
    end
  end



end


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

# game_team has a game_id
# game (data) has a UNIQUE game_id
# All data from game <- that has certain game_id
###   Should be added to each hash of game_team with that game_id


### gt = [{id: 1, t:1, s:3},
###       {id:1, t:2, s:4}
### g = [{id:1, v:6}]

### h_a = [{id:1, t:1, s:3, v:6},
###        {id:1, t:2, s:4, v:6}]

### game_team.map do |gt_hash|
###   to_merge = game.find{|g_hash| g_hash[:game_id] == gt_hash[:game_id]}
###   gt_hash.merge(to_merge)
### end
