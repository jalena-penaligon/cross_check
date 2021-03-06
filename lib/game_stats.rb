module GameStats

  def highest_total_score
    high_score = @data.max_by do |hash|
      (hash[:goals] + hash[:opponent_goals])
    end
    total_score = high_score[:opponent_goals] + high_score[:goals]
  end

  def lowest_total_score
    low_score = @data.min_by do |hash|
      (hash[:goals] + hash[:opponent_goals])
    end
    total_score = low_score[:opponent_goals] + low_score[:goals]
    return 1 if total_score == 0
    return total_score
  end

  def biggest_blowout(data = nil)
    data = @data if data == nil
    blowout_score = data.max_by do |hash|
      (hash[:goals] - hash[:opponent_goals]).abs
    end
    total_score = (blowout_score[:goals] - blowout_score[:opponent_goals]).abs
  end

  def percentage_home_wins(data = nil)
    data = @data if data == nil
    data = subset_data(:hoa, "home", data)
    (winning_percentage(data)).round(2)
  end

  def percentage_visitor_wins(data = nil)
    data = @data if data == nil
    data = subset_data(:hoa, "away", data)
    (winning_percentage(data)).round(2)
  end

  def count_of_games_by_season(data = nil)
    data = @data if data == nil
    group_id = :season
    aggregate = :total_games
    games_per_season = group_and_aggregate(group_id, aggregate, data)
    string_conversion(games_per_season)
    return games_per_season
  end

  def average_goals_per_game
    average_goals_scored.round(2)
  end

  def average_goals_by_season(data = nil)
    data = @data if data == nil
    aggregate = :average_goals_scored
    goals_per_season = subset_group_and_aggregate(nil, :season, aggregate)
    string_conversion(goals_per_season)
    return goals_per_season
  end
end
