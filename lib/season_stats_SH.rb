module SeasonStatsSH

  def most_accurate_team(season_id)
    subsets = {season: season_id.to_i}
    group_id = :teamname
    aggregate = :shooting_percentage
    find_max(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def least_accurate_team(season_id)
    subsets = {season: season_id.to_i}
    group_id = :teamname
    aggregate = :shooting_percentage
    find_min(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def total_goals(data = nil)
    #finds total goals for each team per season.
    #data is the subset from most_accurate_team and least_accurate_team wherein, the team is the key. We have already filtered all games for the desired season.
    if data == nil
      data = @data
    end
    hashID = :goals
    find_total(hashID, data)
  end

  def total_shots(data = nil)
    #finds total shots for each team per season.
    if data == nil
      data = @data
    end
    hashID = :shots
    find_total(hashID, data)
  end

  def shooting_percentage(data = nil)
    if data == nil
      data = @data
    end
    total_goals(data)/total_shots(data).to_f
  end

  def worst_coach(season_id)
    subsets = {season: season_id.to_i}
    group_id = :head_coach
    aggregate = :winning_percentage
    find_min(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def total_wins(data = nil)
    if data == nil
      data = @data
    end
    hashID = :won
    value = true
    data = subset_data(hashID, value, data)
    total_games (data)
  end

  def total_games(data = nil)
   data = @data if data == nil
   data.uniq{|hash| hash[:game_id]}.length
  end

  def winning_percentage(data = nil)
    total_wins(data)/total_games(data).to_f
  end
end
