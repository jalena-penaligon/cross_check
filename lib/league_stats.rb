module LeagueStats

  def count_of_teams
    games_per_team.keys.count
  end

  def games_per_team
    games = Hash.new(0)
    @data.each do |game_team|
      games[game_team[:teamname]] += 1
    end
    games
  end

  def count_games_by_location(hoa)
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == hoa
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

  def count_goals_by_location(hoa)
    goals = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == hoa
        goals[game_team[:teamname]] += game_team[:goals]
      end
    end
    goals
  end

  def wins_by_location(hoa)
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:hoa] == hoa && game_team[:won] == true
        games[game_team[:teamname]] += 1
      end
    end
    games
  end

  def win_percentage_by_location(hoa)
    wins = wins_by_location(hoa)
    num_games = count_games_by_location(hoa)

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

  def goals_allowed
    goals = Hash.new(0)
    @data.each do |game_team|
      goals[game_team[:teamname]] += game_team[:opponent_goals]
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

  def goals_per_game_by_location(hoa)
    games = count_games_by_location(hoa)
    goals_per_game = Hash.new

    count_goals_by_location(hoa).each do |team, goals|
      goals_per_game[team] = (goals /= games[team].to_f).round(3)
    end
    goals_per_game
  end

  def home_goals_per_game
    goals_per_game_by_location("home")
  end

  def visitor_goals_per_game
    goals_per_game_by_location("away")
  end

  def calculate_max_by(attribute)
    attribute.max_by do |team, num|
      num
    end.first
  end

  def calculate_min_by(attribute)
    attribute.min_by do |team, num|
      num
    end.first
  end

  def best_offense
    calculate_max_by(goals_per_game_by_team)
  end

  def worst_offense
    calculate_min_by(goals_per_game_by_team)
  end

  def best_defense
    calculate_min_by(goals_allowed_per_game)
  end

  def worst_defense
    calculate_max_by(goals_allowed_per_game)
  end

  def highest_scoring_visitor
    calculate_max_by(visitor_goals_per_game)
  end

  def highest_scoring_home_team
    calculate_max_by(goals_per_game_by_location("home"))
  end

  def lowest_scoring_visitor
    calculate_min_by(goals_per_game_by_location("away"))
  end

  def lowest_scoring_home_team
    calculate_min_by(home_goals_per_game)
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

    calculate_max_by(winning_percentage)
  end

  def best_fans
    home_wins = win_percentage_by_location("home")
    away_wins = win_percentage_by_location("away")
    difference = {}
    home_wins.each do |team, wins_percentage|
      difference[team] = (wins_percentage - away_wins[team])
    end
    calculate_max_by(difference)
  end

  def worst_fans
    home_wins = win_percentage_by_location("home")
    away_wins = win_percentage_by_location("away")
    difference = {}
    home_wins.each do |team, wins_percentage|
      difference[team] = (away_wins[team] - wins_percentage)
    end

    worst_fans = difference.select do |team, difference|
      difference > 0
    end.max_by do |team, difference|
      difference
    end

    if worst_fans == nil
      return []
    end
  end
end
