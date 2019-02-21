module Aggregators

  def find_total(hashID, data = nil)
    data = @data if data == nil
    return data.sum {|hash| hash[hashID]}
  end

  def home_vs_away_percent_difference(data = nil)
    data = @data if data == nil
    home = percentage_home_wins(data)
    away = percentage_visitor_wins(data)

    difference = home - away
  end

  def pre_reg_season_win_percentage_difference(data = nil)
    data = @data if data == nil
    preseason_data = subset_data(:type, "P", data)
    return 0 if preseason_data.length == 0
    preseason = winning_percentage(preseason_data)
    regular = winning_percentage(subset_data(:type, "R", data))

    difference = preseason - regular
  end

  def winning_percentage(data = nil)
    data = @data if data == nil
    total_wins(data)/total_games(data).to_f
  end

  def rounded_winning_percentage(data = nil)
    data = @data if data == nil
    winning_percentage(data).round(2)
  end

  def shooting_percentage(data = nil)
    data = @data if data == nil
    total_goals(data)/total_shots(data).to_f
  end

  def total_shots(data = nil)
    data = @data if data == nil
    find_total(:shots, data)
  end

  def total_hits(data = nil)
    data = @data if data == nil
    find_total(:hits, data)
  end

  def total_wins(data = nil)
    data = @data if data == nil
    total_games(subset_data(:won, true, data))
  end

  def total_games(data = nil)
    data = @data if data == nil
    data.uniq{ |hash| hash[:game_id] }.length
  end

  def total_goals(data= nil)
    data = @data if data == nil
    find_total(:goals, data)
  end

  def goals_allowed(data = nil)
    data = @data if data == nil
    find_total(:opponent_goals, data)
  end

  def average_goals_scored(data = nil)
    data = @data if data == nil
    (total_goals(data) / total_games(data).to_f).round(2)
  end

  def average_goals_against(data = nil)
    data = @data if data == nil
    goals_allowed(data) / total_games(data).to_f
  end
end
