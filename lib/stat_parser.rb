require 'pry'
require_relative './conversions'

class StatParser
  include Conversions
  def initialize(array_raw_data, array_merge_keys)
    @array_raw_data = array_raw_data
    @array_merge_keys = array_merge_keys
  end

  def parse_data
    merged_data = merge_data
    merged_data = add_opponent_data(merged_data, @array_raw_data[2])
    converted_data = convert_data_types(merged_data)
    return converted_data
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

  def add_opponent_data(merged_data, team_info)
    merged_data.map do |hash|
      opponent_id = find_opponent_id(hash)
      opponent_name = find_team(opponent_id, team_info)

      opponent_goals = find_opponent_goals(hash)
      own_goals = find_own_goals(hash)
      to_merge = {opponent: opponent_name,
                  opponent_goals: opponent_goals,
                  opponent_id: opponent_id,
                  goals: own_goals}
      hash.merge(to_merge)
    end
  end

  def convert_data_types(array_of_hashes)

    converted_values = array_of_hashes.map do |hash|
      hash = delete_keys(hash)
      hash = convert_won_to_boolean(hash)

      hash
    end

    return converted_values
  end

  def find_opponent_id(game_team_hash)
    if game_team_hash[:hoa] == "away"
      id = game_team_hash[:home_team_id]
    else
      id = game_team_hash[:away_team_id]
    end
    return id
  end

  def find_own_goals(hash)
    if hash[:hoa] == "home"
      return hash[:home_goals]
    else
      return hash[:away_goals]
    end
  end

  def find_team(team_id, team_info)
    team =  team_info.find do |hash|
      hash[:team_id] == team_id
    end
    return team[:teamname]
  end


  def find_opponent_goals(hash)
    if hash[:hoa] == "away"
      return hash[:home_goals]
    else
      return hash[:away_goals]
    end
  end

  def merge_hash_arrays(left_array, right_array, merge_key)
    left_array.map do |left_hash|
      right_hash_to_merge = find_hash_to_merge(left_hash, right_array, merge_key)
     left_hash.merge(right_hash_to_merge)
    end
  end

  def find_hash_to_merge(left_hash, right_array, merge_key)
    right_array.find do |right_hash|
      right_hash[merge_key] == left_hash[merge_key]
    end
  end

end
