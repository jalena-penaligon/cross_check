require 'pry'
class StatParser
  attr_reader :merged_data
  def initialize(array_raw_data, array_merge_keys)
    @array_raw_data = array_raw_data
    @array_merge_keys = array_merge_keys
  end

  def parse_data
    merged_data = merge_data

    converted_data = convert_data_types(merged_data)
  end

  def merge_data
    #[game_team, game, team] = @array_raw_data
    current_data = @array_raw_data[0]
    to_merge = @array_raw_data.slice(1..-1)
    to_merge.zip(@array_merge_keys).each do |array_to_merge, merge_key|
      current_data = merge_hash_arrays(current_data, array_to_merge, merge_key)
    end

    return current_data
  end

  def convert_data_types(array_of_hashes)
    to_boolean = [:won]

    converted_values = array_of_hashes.map do |hash|
        hash = delete_keys(hash)
        hash = convert_to_int(hash)
        hash = convert_to_float(hash)

        to_boolean.each do |key|
          if hash[key] == "False"
            hash[key] = false
          else
            hash[key] = true
          end
        end



      hash
    end

  end

  def convert_to_float(hash)
    to_float = [:faceoffwinpercentage]

    to_float.each do |key|
      if hash.keys.include?(key)
        hash[key] = hash[key].to_f
      end
    end

    return hash
  end

  def convert_to_int(hash)
    to_int = [:game_id, :season, :away_goals,:home_goals, :team_id, :goals,
              :shots, :hits, :pim, :powerplayopportunities, :powerplaygoals,
              :giveaways, :takeaways]

    to_int.each do |key|
      if hash.keys.include?(key)
        hash[key] = hash[key].to_i
      end
    end

    return hash
  end

  def delete_keys(hash)
    to_delete = [nil, :venue_time_zone_id, :venue_time_zone_offset,
                :home_rink_side_start, :franchiseid, :venue_link, :venue,
                :abbreviation, :link, :shortname, :away_team_id, :home_team_id,
                :outcome]
    to_delete.each do |key|
      hash.delete(key)
    end

    return hash
  end


  def merge_hash_arrays(merge_to_array, merge_from_array, merge_key)
    # binding.pry
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


### @array_raw_data is three arrays of hashes
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
