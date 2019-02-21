module TeamStats

  def team_info(team_id)
    team_info = {}
    @data.each do |game_team|
      info = {
        "team_id" => game_team[:team_id].to_s,
        "franchise_id" => game_team[:franchiseid].to_s,
        "short_name" => game_team[:shortname],
        "team_name" => game_team[:teamname],
        "abbreviation" => game_team[:abbreviation],
        "link" => game_team[:link]
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

    find_max(subset_group_and_aggregate(subsets, group, agg)).to_s
  end

  def worst_season(team_id)
    subsets = {team_id: team_id.to_i}
    group = :season
    agg = :winning_percentage

    find_min(subset_group_and_aggregate(subsets, group, agg)).to_s
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
    data = multi_subset(subset, @data)
    biggest_blowout(data)
  end

  def worst_loss(team_id)
    subset = {team_id: team_id.to_i, won: false}
    data = multi_subset(subset, @data)
    biggest_blowout(data)
  end

  def head_to_head(team_id)
    subset = {team_id: team_id.to_i}
    group = :opponent_id
    agg = :rounded_winning_percentage
    record = subset_group_and_aggregate(subset, group, agg)

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
      if season_summary[:preseason] == nil
        season_summary[:preseason] = {
          win_percentage: 0.0,
          total_goals_scored: 0,
          total_goals_against: 0,
          average_goals_scored: 0.0,
          average_goals_against: 0.0
        }
      end
      season_summary[:regular_season] = season_summary.delete("R")
      hash[season.to_s] = season_summary
    end
    hash
  end
end
