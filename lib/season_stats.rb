module SeasonStats

  def biggest_bust(season_id)
    # team with biggest decrease between "R" and "P"

    find_max(pre_and_regular_season_difference(season_id))
  end

  def pre_and_regular_season_difference(season_id)
    p_subset = {season: season_id.to_i, type: "P"}
    r_subset = {season: season_id.to_i, type: "R"}
    group = :teamname
    aggregate = :winning_percentage

    preseason = subset_group_and_aggregate(p_subset, group, aggregate)
    reg_season = subset_group_and_aggregate(r_subset, group, aggregate)

    diff = {}
    preseason.each do |team, percentage|
      diff[team] = percentage - reg_season[team]
    end
  end

  def biggest_surprise(season_id)
    # team with biggest increase betwee "R" and "P"
    find_min(pre_and_regular_season_difference(season_id))
  end

  def winningest_coach(season_id)
    # coach with highest win pct for season
    subset = {season: season_id.to_i}
    group = :head_coach
    agg = :winning_percentage
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def worst_coach(season_id)
    # coach with lowest win pct for season
    subset = {season: season_id.to_i}
    group = :head_coach
    agg = :winning_percentage
    find_min(subset_group_and_aggregate(subset, group, agg))
  end

  def most_accurate_team(season_id)
    # name of team w/ best shoot pct
    subset = {season: season_id.to_i}
    group = :teamname
    agg = :shooting_percentage
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def least_accurate_team(season_id)
    # name of team w/ worst shoot pct
    subset = {season: season_id.to_i}
    group = :teamname
    agg = :shooting_percentage
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
end
