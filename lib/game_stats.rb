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
  end

  def biggest_blowout
    blowout_score = @data.max_by do |hash|
      (hash[:goals] - hash[:opponent_goals]).abs
    end
    total_score = (blowout_score[:goals] - blowout_score[:opponent_goals]).abs
  end

  def percentage_home_wins
    number_home_wins = @data.select do |hash|
      (hash[:hoa] == "home") && (hash[:won] == true)
    end
    percent_home_wins = ((number_home_wins.count) / total_number_of_games).round(2)
  end

  def percentage_visitor_wins
    number_visitor_wins = @data.select do |hash|
      hash[:hoa] == "away" && hash[:won] == true
    end
    percent_home_wins = ((number_visitor_wins.count) / total_number_of_games).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    unique_seasons = find_unique_seasons
    unique_seasons.each do |seasonid|
      games = @data.select do |game_team_info|
        game_team_info[:season] == seasonid
      end
      seasons[seasonid] = total_number_of_games(games)
    end
    return seasons
  end

  def average_goals_per_game(data_to_use = nil)
    if data_to_use == nil
      data_to_use = @data
    end
    total_goals = data_to_use.sum do |key, value|
      key[:goals]
    end
    average_goals_per_game = (total_goals/total_number_of_games(data_to_use)).round(2)
  end

  def average_goals_by_season
    unique_seasons = find_unique_seasons

    average_goals_in_season = Hash.new

    unique_seasons.each do |season_id|
      games_in_season = @data.find_all do |game_team_info|
        game_team_info[:season] ==  season_id
      end
    average_goals_in_season[season_id] = average_goals_per_game(games_in_season)
    end
    return average_goals_in_season
  end

  def total_number_of_games(data_to_use = nil)
    if data_to_use == nil
      data_to_use = @data
    end
    total_number_of_games = ((data_to_use.count)/2).to_f
  end

  def find_unique_seasons
    @data.map do |game_team_info|
      game_team_info[:season]
    end.uniq
  end
end
