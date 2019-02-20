module TeamStats

  def team_info(team_id)
    team_info = {}
    @data.each do |game_team|
      info = {
        team_id: game_team[:team_id],
        franchise_id: game_team[:franchiseid],
        short_name: game_team[:shortname],
        team_name: game_team[:teamname],
        abbreviation: game_team[:abbreviation],
        link: game_team[:link]
      }
      team_info[game_team[:team_id]] = info
    end
    team_info[team_id.to_i]
  end

  def games_per_season(team_id)
    subsets = {team_id: team_id.to_i}
    group = :season
    agg = :total_games

    subset_group_and_aggregate(subsets, group, agg)
  end

  def best_season(team_id)
    subsets = {team_id: team_id.to_i}
    group = :season
    agg = :winning_percentage

    find_max(subset_group_and_aggregate(subsets, group, agg))
  end

  def worst_season(team_id)
    subsets = {team_id: team_id.to_i}
    group = :season
    agg = :winning_percentage

    find_min(subset_group_and_aggregate(subsets, group, agg))
  end

  def average_win_percentage(team_id)
    data = subset_data(:team_id, team_id.to_i)
    winning_percentage(data).round(2)
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
    group = :game_id
    agg = :goal_difference

    find_max(subset_group_and_aggregate(subset, group, agg), "value")
  end

  def worst_loss(team_id)
    subset = {team_id: team_id.to_i, won: false}
    group = :game_id
    agg = :goal_difference

    find_min(subset_group_and_aggregate(subset, group, agg), "value").abs
  end

  def head_to_head(team_id)
    subset = {team_id: team_id.to_i}
    group = :opponent
    agg = :winning_percentage
    subset_group_and_aggregate(subset, group, agg)
  end

  def summary(data)
    summary = {
      win_percentage: winning_percentage(data).round(2),
      total_goals_scored: total_goals(data),
      total_goals_against: goals_allowed(data),
      average_goals_scored: average_goals_scored(data).round(2),
      average_goals_against: average_goals_against(data).round(2)
    }
  end

  def seasonal_summary(team_id)
    data = subset_data(:team_id, team_id.to_i)
    all_seasons = data.map do |game|
      game[:season]
    end.uniq

    hash = {}
    all_seasons.each do |season|
      subsets = {team_id: team_id.to_i, season: season}
      group_id = :type
      aggregate = :summary
      season_summary = subset_group_and_aggregate(subsets, group_id, aggregate)
      season_summary[:preseason] = season_summary.delete("P")
      season_summary[:regular_season] = season_summary.delete("R")
      hash[season] = season_summary
    end
    hash
  end

  ######################
  ### HELPER METHODS###
  ######################
  
  def goal_difference(data = nil)
    data = @data if data == nil
    goals = total_goals(data)
    opponent_goals = goals_allowed(data)
    difference = goals - opponent_goals
  end

  def goals_allowed(data = nil)
    data = @data if data == nil
    find_total(:opponent_goals, data)
  end

  def average_goals_scored(data = nil)
    data = @data if data == nil
    total_goals(data) / total_games(data).to_f
  end

  def average_goals_against(data = nil)
    data = @data if data == nil
    goals_allowed(data) / total_games(data).to_f
  end
end
