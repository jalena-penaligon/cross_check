module GameStats

  def highest_total_score
    high_score = @data.max_by do |hash|
      (hash[:away_goals] + hash[:home_goals])
    end
    total_score = high_score[:away_goals] + high_score[:home_goals]
  end

  def lowest_total_score
    low_score = @data.min_by do |hash|
      (hash[:away_goals] + hash[:home_goals])
    end
    total_score = low_score[:away_goals] + low_score[:home_goals]
  end

  def biggest_blowout
    blowout_score = @data.max_by do |hash|
      (hash[:away_goals] - hash[:home_goals]).abs
    end
  total_score = (blowout_score[:away_goals] - blowout_score[:home_goals]).abs
  end

  def percentage_home_wins
    number_home_wins = @data.select do |hash|
      hash[:hoa] == "home" && hash[:won] == true
    end
    total_number_of_games = ((@data.count)/2).to_f
    percent_home_wins = ((number_home_wins.count) / total_number_of_games).round(3)
  end

  def percentage_visitor_wins
    number_visitor_wins = @data.select do |hash|
      hash[:hoa] == "away" && hash[:won] == true
    end
    total_number_of_games = ((@data.count)/2).to_f
    percent_home_wins = ((number_visitor_wins.count) / total_number_of_games).round(3)
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    @data.each do |game_team|
      seasons[game_team[:season]] += 1
    end

    seasons.each do |key, value|
      seasons[key] = value/2
    end
  end
end
