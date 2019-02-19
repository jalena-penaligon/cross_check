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

  def biggest_bust(season)
    subset = {season: season.to_i}
    group = :teamname
    agg = :win_percentage_difference

    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def calculate_win_percentage(data = nil)
    data = @data if data == nil
    wins = total_wins(data)
    games = total_games(data)

    win_percentage = wins / games.to_f
  end

  def win_percentage_difference(data = nil)
    data = @data if data == nil
    preseason = calculate_win_percentage(subset_data(:type, "P", data))
    regular = calculate_win_percentage(subset_data(:type, "R", data))

    difference = preseason - regular

  end

  def biggest_surprise(season)
    subset = {season: season.to_i}
    group = :teamname
    agg = :win_percentage_difference

    find_min(subset_group_and_aggregate(subset, group, agg))
  end

  def winningest_coach(season)
    data = @data if data == nil
    subset = {season: season.to_i}
    group = :head_coach
    agg = :calculate_win_percentage

    find_max(subset_group_and_aggregate(subset, group, agg))
  end

end
