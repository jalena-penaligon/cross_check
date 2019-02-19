module LeagueStats

  def divide(value1, value2)
    result = Hash.new(0)
    value1.each do |team, num|
      result[team] = (num /= value2[team].to_f).round(2)
    end
    result
  end

  def subtract(value1, value2)
    result = Hash.new(0)
    value1.each do |team, num|
      result[team] = (num - value2[team])
    end
    result
  end

  def total_games(data = nil)
    data = @data if data == nil
    data.uniq do |hash|
      hash[:game_id]
    end.length
  end

  def total_goals(data= nil)
    data = @data if data == nil
    find_total(:goals, data)
  end

  def total_goals_allowed(data= nil)
    data = @data if data == nil
    find_total(:opponent_goals, data)
  end

  def count_of_teams
    game_grouping(:team_id).length
  end

  def games_per_team
    group_id = :teamname
    aggregate = :total_games
    group_and_aggregate(group_id, aggregate)
  end

  def count_games_by_location(hoa)
    subset = {hoa: hoa}
    group = :teamname
    agg = :total_games

    subset_group_and_aggregate(subset, group, agg)
  end

  def total_team_goals
    group_id = :teamname
    aggregate = :total_goals

    group_and_aggregate(group_id, aggregate)
  end

  def count_goals_by_location(hoa)
    subset = {hoa: hoa}
    group = :teamname
    agg = :total_goals

    subset_group_and_aggregate(subset, group, agg)
  end

  def wins_by_location(hoa)
    subset = {hoa: hoa, won: true}
    group = :teamname
    agg = :total_games

    subset_group_and_aggregate(subset, group, agg)
  end

  def win_percentage_by_location(hoa)
    wins = wins_by_location(hoa)
    games = count_games_by_location(hoa)

    divide(wins, games)
  end

  def goals_scored_per_game(game_type, goal_type)
    games = game_type
    goals = goal_type

    divide(goals, games)
  end

  def goals_per_game_by_team
    goals_scored_per_game(games_per_team, total_team_goals)
  end

  def goals_allowed
    group_id = :teamname
    aggregate = :total_goals_allowed
    group_and_aggregate(group_id, aggregate)
  end

  def goals_allowed_per_game
    goals_scored_per_game(games_per_team, goals_allowed)
  end

  def goals_per_game_by_location(hoa)
    game_type = count_games_by_location(hoa)
    goal_type = count_goals_by_location(hoa)
    goals_scored_per_game(game_type, goal_type)
  end

  def home_goals_per_game
    goals_per_game_by_location("home")
  end

  def best_offense
    find_max(goals_per_game_by_team)
  end

  def worst_offense
    find_min(goals_per_game_by_team)
  end

  def best_defense
    find_min(goals_allowed_per_game)
  end

  def worst_defense
    find_max(goals_allowed_per_game)
  end

  def highest_scoring_visitor
    find_max(goals_per_game_by_location("away"))
  end

  def highest_scoring_home_team
    find_max(goals_per_game_by_location("home"))
  end

  def lowest_scoring_visitor
    find_min(goals_per_game_by_location("away"))
  end

  def lowest_scoring_home_team
    find_min(home_goals_per_game)
  end

  def winningest_team
    subset = {won: true}
    group = :teamname
    agg = :total_games
    games_won = subset_group_and_aggregate(subset, group, agg)
    games_played = group_and_aggregate(group, agg)

    find_max(divide(games_won, games_played))
  end

  def best_fans
    home_wins = win_percentage_by_location("home")
    away_wins = win_percentage_by_location("away")

    find_max(subtract(home_wins, away_wins))
  end

  def worst_fans
    home_wins = win_percentage_by_location("home")
    away_wins = win_percentage_by_location("away")
    difference = subtract(away_wins, home_wins)

    if difference.values.all? {|num| num < 0}
      return []
    else difference.values.any? {|num| num > 0}
      find_max(difference)
    end
  end
end
