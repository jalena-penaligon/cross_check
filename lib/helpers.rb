module Helpers

  def subset_data(hashID, value, data = nil)
    data = @data if data == nil
    return data.find_all {|hash| hash[hashID] == value}
  end

  def multi_subset(ids_values, data = nil)
    data = @data if data == nil
    return data if ids_values == nil

    ids_values.each do |hashID, value|
      data = subset_data(hashID, value, data)
    end
    return data
  end

  def game_grouping(hashID, data = nil)
    data = @data if data == nil
    data.group_by{|hash| hash[hashID]}
  end

  def hash_aggregate(hash, method)
    hash.each do |key, value|
      hash[key] = self.send method, value
    end
    return hash
  end

  def find_max(hash, name_or_value = "name")
    if name_or_value == "name" then index = 0 else index = 1 end
    hash.max_by{|key,value| value}[index]
  end

  def find_min(hash,  name_or_value = "name")
    if name_or_value == "name" then index = 0 else index = 1 end
    hash.min_by{|key, value| value}[index]
  end

  def subset_group_and_aggregate(subsets, group_id, aggregate, data = nil)
    data = @data if data == nil
    data = multi_subset(subsets,data)
    return group_and_aggregate(group_id, aggregate, data)
  end

  def group_and_aggregate(group_id, aggregate, data = nil)
    data = @data if data == nil
    groups = game_grouping(group_id, data)
    return hash_aggregate(groups, aggregate)
  end

end
