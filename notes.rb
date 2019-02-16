# groupby(hashID, value): # either return a hash or a list for that specific value



# blank per blank
# blank1 per blank2

# blank1 goals, wins, hits,

# blank2 season, game

# subset :hashID == value


class Test
  def initialize(data)
    @data = data
  end

  def game_grouping(hashID, data = nil)
    data = @data if data == nil
    data.group_by{|hash| hash[hashID]}
  end

  def hash_aggregate(hash, method)
    hash.each{ |key, value| hash[key] = self.send method, value}
    return hash
  end

  def group_and_aggregate(group_id, aggregate)
    groups = game_grouping(group_id)
    return hash_aggregate(groups, aggregate)
  end

  def find_total(hashID, data = nil)
    data = @data if data == nil
    return data.sum {|hash| hash[hashID]}
  end

  def average_of_id_per_game(hashID, data = nil)
    data = @data if data == nil
    total = find_total(hashID, data)
    (total.to_f / total_games(data)).round(2)
  end

  def total_games(data = nil)
    data = @data if data == nil
    data.uniq{|hash| hash[:n]}.length# NOTE: ]}.length
  end

  def best_defense
    avg_goals_allowed = group_and_aggregate(:n, :average_of_id_per_game, :g)
  end

end
arr_hash = [{n:1,t:1, g:2}, {n:1, t:2, g:3},
  {n:2,t:1, g:3},{n:2, t:2, g:2},{n:3,t:1, g:2}, {n:3,t:2, g:3}]
t = Test.new(arr_hash)

h =  t.game_grouping(:t)
puts h
puts t.hash_aggregate(h, :average_of_id_per_game, :g)
# puts t.average_of_id_per_game(:g, h[1])
# puts t.hash_aggregate(t.game_grouping(:n),:average_of_id_)
