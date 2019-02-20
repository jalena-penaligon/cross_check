module Helpers

  # teamID is a symbol in the hash
  # value is a value that that symbol will be

  ##########
  # Subsetting Methods
  ##########

  def subset_data(hashID, value, data = nil)
    data = @data if data == nil
    return data.find_all {|hash| hash[hashID] == value}
  end

  ### Takes in a dictionary of {hashID:value, hashID2:value2}}
  def multi_subset(ids_values, data = nil)
    data = @data if data == nil
    return data if ids_values == nil

    ids_values.each do |hashID, value|
      data = subset_data(hashID, value, data)
    end
    return data
  end

  # All subsets return a single list of hashes

  ##############
  # Grouping Methods
  ##############
  def game_grouping(hashID, data = nil)
    data = @data if data == nil
    data.group_by{|hash| hash[hashID]}
  end
  # hash with keys equal to all the values associated
  # with that hashID

  ###############
  # Aggregation Method
  ##############

  # hash is the game hash on the left
  # method is :total_goals

  # we are in the stat_tracker
  # The method we want is an INSTANCE method of stat_tracker

  # .send only works when called on an OBJECT
  # .send gets you access to INSTANCE METHODS

  # self gets us the CURRENT stat_tracker object

  # The send statment will read " self.send :total_goals , value"
  def hash_aggregate(hash, method)
    hash.each do |key, value|
      hash[key] = self.send method, value
    end
    return hash
  end

  ##############
  # Find Max or Min
  ##############

  def find_max(hash, name_or_value = "name")
    if name_or_value == "name" then index = 0 else index = 1 end
    hash.max_by{|key,value| value}[index]
  end

  def find_min(hash,  name_or_value = "name")
    if name_or_value == "name" then index = 0 else index = 1 end
    hash.min_by{|key, value| value}[index]
  end

  ################
  # Combining the Above
  ################

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

  #############
  # Specific Methods for Aggregation
  ############
  ### To use a specific aggregation method
  ### It must accept ONE AND ONLY ONE argument -- the data

  #### For finding Total in data
  def find_total(hashID, data = nil)
    data = @data if data == nil
    return data.sum {|hash| hash[hashID]}
  end
end
