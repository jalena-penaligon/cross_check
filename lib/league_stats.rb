module LeagueStats

  def count_of_teams
    @data.map do |game_team|
      game_team[:team_id]
    end.uniq.count
  end

  def aggregate_team_goals
    @data.inject({}) do |team_hash, game_team|
      team_hash[game_team[:teamname]] = game_team[:goals]
      team_hash
    end
  end

  def best_offense
    aggregate_team_goals.max_by do |team, scores|
      scores
    end.first
  end

  def worst_offense
    aggregate_team_goals.min_by do |team, scores|
      scores
    end.first
  end
end
