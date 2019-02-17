module SeasonStatsWP


  def total_hits(data = nil)
    data = @data if data == nil
    find_total(:hits, data)
  end

  def total_goals(data= nil)
    data = @data if data == nil
    find_total(:goals, data)
  end

  def most_hits(season_id)
    # name of team with most hits in season
    subset = {season: season_id.to_i}
    group = :teamname
    agg = :total_hits
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def least_hits(season_id)
    # name of team with least hits in season
    subset = {season: season_id.to_i}
    group = :teamname
    agg = :total_hits
    find_min(subset_group_and_aggregate(subset, group, agg))
  end

  def power_play_goal_percentage(season_id)
    data = subset_data( :season, season_id.to_i)
    ppg = find_total(:powerplaygoals, data)
    goals = total_goals(data)

    return (ppg.to_f/goals).round(2)
  end
end
