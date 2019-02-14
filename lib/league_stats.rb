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

  def total_team_goals
    teams = Hash.new(0)
    @data.each do |game_team|
      teams[game_team[:teamname]] += game_team[:goals]
    end
    teams
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


  # def best_defense
  # end
end
