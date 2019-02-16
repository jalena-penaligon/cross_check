module GameStats


  def highest_total_score
    game_aggregate(:goals, :opponent_goals, :+).max
  end

  def lowest_total_score
    lowest = game_aggregate(:goals, :opponent_goals, :+).min
    return 1 if lowest == 0
    return lowest
  end

  def biggest_blowout(data = nil)
    data = @data if data == nil
    game_aggregate(:goals, :opponent_goals, :-, data).map{|diff| diff.abs}.max
  end


  def percentage_home_wins(data = nil)
    data = @data if data == nil
    data = subset_data(:hoa, "home", data)
    return winning_percentage(data)
  end

  def percentage_visitor_wins(data = nil)
    data = @data if data == nil
    data = subset_data(:hoa, "away", data)
    return winning_percentage(data)
  end

  def home_vs_away_win_pct(data = nil)
    data = @data if data == nil
    return percentage_home_wins(data) - percentage_visitor_wins(data)
  end

  def average_goals_allowed_per_game(data = nil)
    data = @data if data == nil
    return average_of_id_per_game(:opponent_goals, data)
  end

  def average_goals_per_game(data = nil)
    data = @data if data == nil
    return average_of_id_per_game(:goals, data)
  end

  def count_of_games_by_season
    seasons = game_grouping(:season)
    return hash_aggregate(seasons, :total_games)
  end

  def average_goals_by_season
    seasons = game_grouping(:season)
    return hash_aggregate(seasons, :average_goals_per_game)
  end

end
