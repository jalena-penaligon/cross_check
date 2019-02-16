module Helpers

  def subset_data(hashID, value, data = nil)
    data = @data if data == nil
    return data.find_all {|hash| hash[hashID] == value}
  end

  def game_grouping(hashID, data = nil)
    data = @data if data == nil
    data.group_by{|hash| hash[hashID]}
  end

  def multi_subset(ids_values, data = nil)
    data = @data if data == nil
    return data if ids_values == nil
    
    ids_values.each do |hashID, value|
      data = subset_data(hashID, value, data)
    end
    return data
  end

  def find_total(hashID, data = nil)
    data = @data if data == nil
    return data.sum {|hash| hash[hashID]}
  end

  def total_goals(data = nil)
    data = @data if data == nil
    return find_total(:goals, data)
  end

  def total_hits(data = nil)
    data = @data if data == nil
    return find_total(:hits, data)
  end

  def shooting_percentage(data= nil)
    data = @data if data == nil
    shots = find_total(:shots, data)
    goals = find_total(:goals, data)
    return (goals.to_f/shots).round(4)
  end

  def total_goals_against(data = nil)
    data = @data if data == nil
    return find_total(:opponent_goals, data)
  end

  def game_aggregate(hashID1, hashID2, relation, data = nil) #relation is a symbol
    data = @data if data == nil
    return data.map{|hash| hash[hashID1].send relation, hash[hashID2]}
  end

  def total_games(data = nil)
    data = @data if data == nil
    data.uniq{|hash| hash[:game_id]}.length
  end

  def winning_percentage(data = nil)
    data = @data if data == nil
    wins = total_games(subset_data(:won, true, data))
    games = total_games(data)
    return 0 if games == 0
    return (wins.to_f/total_games(data)).round(2)
  end

  def average_of_id_per_game(hashID, data = nil)
    data = @data if data == nil
    total = find_total(hashID, data)
    (total.to_f / total_games(data)).round(2)
  end

  def hash_aggregate(hash, method)
    hash.each{ |key, value| hash[key] = self.send method, value}
    return hash
  end

  def hash_multi_aggregate(hash, methods)
    new_hash = Hash.new(Hash.new)
    methods.each do |method|
      agg_hash = hash_aggregate(hash, method)
      agg_hash.each{ |key, value| new_hash[key][method] = value }
    end
    return new_hash
  end

  def group_and_multi_aggregate(group_id, methods, data = nil)
    data = @data if data == nil
    groups = game_grouping(group_id, data)
    return hash_multi_aggregate(groups, methods)
  end

  def group_and_aggregate(group_id, aggregate, data = nil)
    data = @data if data == nil
    groups = game_grouping(group_id, data)
    return hash_aggregate(groups, aggregate)
  end

  def subset_group_and_aggregate(subsets, group_id, aggregate)
    data = multi_subset(subsets)
    return group_and_aggregate(group_id, aggregate, data)
  end

  def find_max(hash, name_or_value = "name")
    if name_or_value == "name" then index = 0 else index = 1 end
    hash.max_by{|key,value| value}[index]
  end

  def find_min(hash,  name_or_value = "name")
    if name_or_value == "name" then index = 0 else index = 1 end
    hash.min_by{|key, value| value}[index]
  end

end
