module TeamStats
  def best_season(team_id)
    subset = {team_id: team_id.to_i}
    group = :season
    agg = :winning_percentage
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def worst_season(team_id)
    subset = {team_id: team_id.to_i}
    group = :season
    agg = :winning_percentage
    find_min(subset_group_and_aggregate(subset, group, agg))
  end

  def average_win_percentage(team_id)
    data = subset_data(:team_id, team_id.to_i)
    winning_percentage(data)
  end

  def most_goals_scored(team_id)
    subset = {team_id: team_id.to_i}
    group = :game_id
    agg = :total_goals
    find_max(subset_group_and_aggregate(subset, group, agg), "value")
  end

  def fewest_goals_scored(team_id)
    subset = {team_id: team_id.to_i}
    group = :game_id
    agg = :total_goals
    find_min(subset_group_and_aggregate(subset, group, agg), "value")
  end

  def favorite_opponent(team_id)
    subset = {team_id: team_id.to_i}
    group = :opponent
    agg = :winning_percentage
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def rival(team_id)
    subset = {team_id: team_id.to_i}
    group = :opponent
    agg = :winning_percentage
    find_min(subset_group_and_aggregate(subset, group, agg))
  end

  def biggest_team_blowout(team_id)
    subset = {team_id: team_id.to_i, won: true}
    data = multi_subset(subset)
    biggest_blowout(data)
  end

  def worst_loss(team_id)
    subset = {team_id: team_id.to_i, won: false}
    data = multi_subset(subset)
    biggest_blowout(data)
  end

  def head_to_head(team_id)
    subset = {team_id: team_id.to_i}
    group = :opponent
    agg = :winning_percentage
    subset_group_and_aggregate(subset, group, agg)
  end

  # def seasonal_summary(team_id)
  #   subset = {team_id: team_id.to_i}
  #   group = :opponent_name
  #   aggs = [:winning_percentage, :total_goals, :total_goals_against,
  #     :average_goals_per_game, :average_goals_allowed_per_game]
  #
  # end

  # def team_info
  #
  # end

end
