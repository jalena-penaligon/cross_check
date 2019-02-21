module SeasonStats

  def biggest_bust(season)
    subset = {season: season.to_i}
    group = :teamname
    agg = :pre_reg_season_win_percentage_difference
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def biggest_surprise(season)
    subset = {season: season.to_i}
    group = :teamname
    agg = :pre_reg_season_win_percentage_difference
    find_min(subset_group_and_aggregate(subset, group, agg))
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

  def most_accurate_team(season_id)
    subsets = {season: season_id.to_i}
    group_id = :teamname
    aggregate = :shooting_percentage
    int = subset_group_and_aggregate(subsets, group_id, aggregate)
    binding.pry
    find_max(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def least_accurate_team(season_id)
    subsets = {season: season_id.to_i}
    group_id = :teamname
    aggregate = :shooting_percentage
    find_min(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def winningest_coach(season)
    subset = {season: season.to_i}
    group = :head_coach
    agg = :winning_percentage
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def worst_coach(season_id)
    subsets = {season: season_id.to_i}
    group_id = :head_coach
    aggregate = :winning_percentage
    find_min(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

end
