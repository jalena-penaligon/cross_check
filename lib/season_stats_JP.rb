module SeasonStatsJP

  def total_games(data = nil)
    data = @data if data == nil
    data.uniq do |hash|
      hash[:game_id]
    end.length
  end

  def total_wins(data = nil)
    data = @data if data == nil
    total_games(subset_data(:won, true, data))
  end

  def games_by_type(season, type, data = nil)
    data = @data if data == nil
    subset = {season: season.to_i, type: type}
    group = :teamname
    agg = :total_games

    subset_group_and_aggregate(subset, group, agg)
  end

  def wins_by_type(season, type, data = nil)
    data = @data if data == nil
    subset = {season: season.to_i, type: type}
    group = :teamname
    agg = :total_wins

    subset_group_and_aggregate(subset, group, agg)
  end

  def calculate_win_percentage(games, wins)
    percentage = Hash.new(0)
    wins.each do |team, wins|
      percentage[team] = (wins /= games[team].to_f).round(2)
    end
    percentage
  end

  def win_percentage_by_type(season, type, data = nil)
    games = games_by_type(season, type, data = nil)
    wins = wins_by_type(season, type, data = nil)

    calculate_win_percentage(games, wins)
  end

  def win_percentage_difference(season)
    preseason = win_percentage_by_type(season, "P", data = nil)
    regular = win_percentage_by_type(season, "R", data = nil)

    difference = Hash.new(0)
    preseason.each do |team, win_percent|
      difference[team] = (win_percent -= regular[team]).round(2)
    end
    difference
  end

  def biggest_bust(season)
    find_max(win_percentage_difference(season))
  end

  def biggest_surprise(season)
    find_min(win_percentage_difference(season))
  end

  def games_by_coach(season)
    data = @data if data == nil
    subset = {season: season.to_i}
    group = :head_coach
    agg = :total_games

    subset_group_and_aggregate(subset, group, agg)
  end

  def wins_by_coach(season, won = true, data = nil)
    data = @data if data == nil
    subset = {season: season.to_i, won: won}
    group = :head_coach
    agg = :total_games

    subset_group_and_aggregate(subset, group, agg)
  end

  def coach_winning_percentage(season)
    games = games_by_coach(season)
    wins = wins_by_coach(season)

    calculate_win_percentage(games, wins)
  end

  def winningest_coach(season)
    find_max(coach_winning_percentage(season))
  end
end
