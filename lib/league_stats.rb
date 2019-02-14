module LeagueStats

  def count_of_teams
    @data.map do |game_team|
      game_team[:team_id]
    end.uniq.count
  end

  def games_per_team
    games = Hash.new(0)
    @data.each do |game_team|
      games[game_team[:teamname]] += 1
    end
    games
  end

  def count_home_games
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "home"
        games[game_team[:teamname]] += 1
      end
    end
    games
  end

  def count_away_games
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "away"
        games[game_team[:teamname]] += 1
      end
    end
    games
  end

  def total_team_goals
    teams = Hash.new(0)
    @data.each do |game_team|
      teams[game_team[:teamname]] += game_team[:goals]
    end
    teams
  end

  def visitor_goals
    visitor_goals = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "away"
        visitor_goals[game_team[:teamname]] += game_team[:goals]
      end
    end
    visitor_goals
  end

  def home_goals
    home_goals = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "home"
        home_goals[game_team[:teamname]] += game_team[:goals]
      end
    end
    home_goals
  end

  def count_away_wins
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "away" && game_team[:won] == true
        games[game_team[:teamname]] += 1
      end
    end
    games
  end

  def count_home_wins
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "home" && game_team[:won] == true
        games[game_team[:teamname]] += 1
      end
    end
    games
  end

  def away_win_percentage
    wins = count_away_wins
    num_games = count_away_games

    percentage = Hash.new(0)
    wins.each do |team, wins|
      percentage[team] = (wins /= num_games[team].to_f).round(3)
    end
    percentage
  end

  def home_win_percentage
    wins = count_home_wins
    num_games = count_home_games

    percentage = Hash.new(0)
    wins.each do |team, wins|
      percentage[team] = (wins /= num_games[team].to_f).round(3)
    end
    percentage
  end

  def goals_per_game_by_team
    games = games_per_team
    goals_per_game = Hash.new

    total_team_goals.each do |team, goals|
      goals_per_game[team] = (goals /= games[team].to_f)
    end
    goals_per_game
  end

  def best_offense
    goals_per_game_by_team.max_by do |team, goals_per_game|
      goals_per_game
    end.first
  end

  def worst_offense
    goals_per_game_by_team.min_by do |team, goals_per_game|
      goals_per_game
    end.first
  end

  def goals_allowed
    goals = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == "away"
        goals[game_team[:teamname]] += game_team[:home_goals]
      elsif game_team[:hoa] == "home"
        goals[game_team[:teamname]] += game_team[:away_goals]
      end
    end
    goals
  end

  def goals_allowed_per_game
    games = games_per_team
    goals_allowed_per_game = Hash.new

    goals_allowed.each do |team, goals|
      goals_allowed_per_game[team] = (goals /= games[team].to_f)
    end
    goals_allowed_per_game
  end

  def best_defense
    goals_allowed_per_game.min_by do |team, goals_allowed_per_game|
      goals_allowed_per_game
    end.first
  end

  def worst_defense
    goals_allowed_per_game.max_by do |team, goals_allowed_per_game|
      goals_allowed_per_game
    end.first
  end

  def home_goals_per_game
    home_games = count_home_games
    home_goals_per_game = Hash.new

    home_goals.each do |team, goals|
      home_goals_per_game[team] = (goals /= home_games[team].to_f)
    end
    home_goals_per_game
  end

  def visitor_goals_per_game
    visitor_games = count_away_games
    visitor_goals_per_game = Hash.new

    visitor_goals.each do |team, goals|
      visitor_goals_per_game[team] = (goals /= visitor_games[team].to_f)
    end
    visitor_goals_per_game
  end

  def highest_scoring_visitor
    visitor_goals_per_game.max_by do |team, goals_per_game|
      goals_per_game
    end.first
  end

  def highest_scoring_home_team
    home_goals_per_game.max_by do |team, goals_per_game|
      goals_per_game
    end.first
  end

  def lowest_scoring_visitor
    visitor_goals_per_game.min_by do |team, goals_per_game|
      goals_per_game
    end.first
  end

  def lowest_scoring_home_team
    home_goals_per_game.min_by do |team, goals_per_game|
      goals_per_game
    end.first
  end

  def winningest_team
    games_won = Hash.new(0)
    @data.each do |game_team|
      if game_team[:won] == true
        games_won[game_team[:teamname]] += 1
      end
    end
    games_played = games_per_team
    winning_percentage = Hash.new(0)
    games_won.each do |team, games_won|
      winning_percentage[team] = (games_won /= games_played[team].to_f)
    end

    winning_percentage.max_by do |team, wins|
      wins
    end.first
  end

  def best_fans
    home_wins = home_win_percentage
    away_wins = away_win_percentage
    difference = {}
    home_wins.each do |team, wins_percentage|
      difference[team] = (wins_percentage - away_wins[team])
    end

    difference.max_by do |team, difference|
      difference
    end.first
  end

  def worst_fans
    home_wins = home_win_percentage
    away_wins = away_win_percentage
    difference = {}
    home_wins.each do |team, wins_percentage|
      difference[team] = (away_wins[team] - wins_percentage)
    end

    worst_fans = difference.max_by do |team, difference|
      difference
    end

    if worst_fans[1] < 0
      return nil
    else
      return worst_fans.first
    end
  end
end