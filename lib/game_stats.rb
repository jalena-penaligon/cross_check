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
    number_of_games = ((@data.count)/2).to_f
    percent_home_wins = ((number_home_wins.count) / number_of_games).round(3)
  end
end
