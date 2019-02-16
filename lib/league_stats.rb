module LeagueStats

  def winningest_team
    subset = nil
    group = :teamname
    agg= :winning_percentage
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def best_fans
    subset = nil
    group = :teamname
    agg = :home_vs_away_win_pct
    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def worst_fans
    sub
    teams = group_and_aggregate(:teamname, :home_vs_away_win_pct)
    teams.find_all{ |team, h_vs_a_pct| h_vs_a_pct <0}
  end

  def best_offense
    avg_goals = group_and_aggregate(:teamname, :average_goals_per_game)
    return find_max(avg_goals)
  end

  def worst_offense
    avg_goals = group_and_aggregate(:teamname, :average_goals_per_game)
    return find_min(avg_goals)
  end

  def best_defense
    gaa = group_and_aggregate(:teamname, :average_goals_allowed_per_game)
    return find_min(gaa)
  end

  def worst_defense
    gaa = group_and_aggregate(:teamname, :average_goals_allowed_per_game)
    return find_max(gaa)
  end

  def count_of_teams
    game_grouping(:teamname).length
  end

  def highest_scoring_visitor
    visitor_goals = subset_group_and_aggregate({hoa: "away"}, :teamname,
                                                :average_goals_per_game)
    return find_max(visitor_goals)
  end

  def lowest_scoring_visitor
    visitor_goals = subset_group_and_aggregate({hoa: "away"}, :teamname,
                                                :average_goals_per_game)
    return find_min(visitor_goals)
  end

  def highest_scoring_home_team
    home_goals = subset_group_and_aggregate({hoa: "home"}, :teamname,
                                                :average_goals_per_game)
    return find_max(home_goals)
  end

  def lowest_scoring_home_team
    home_goals = subset_group_and_aggregate({hoa: "home"}, :teamname,
                                                :average_goals_per_game)
    find_min(home_goals)
  end
end
