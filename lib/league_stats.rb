module LeagueStats

  def count_of_teams
    game_grouping(:team_id).length
  end

  def best_offense
    subsets = nil
    group_id = :teamname
    aggregate = :average_goals_scored

    find_max(subset_group_and_aggregate(subsets, group_id, aggregate, data = nil))
  end

  def worst_offense
    subsets = nil
    group_id = :teamname
    aggregate = :average_goals_scored

    find_min(subset_group_and_aggregate(subsets, group_id, aggregate, data = nil))
  end

  def best_defense
    subsets = nil
    group_id = :teamname
    aggregate = :average_goals_against

    find_min(subset_group_and_aggregate(subsets, group_id, aggregate, data = nil))
  end

  def worst_defense
    subsets = nil
    group_id = :teamname
    aggregate = :average_goals_against

    find_max(subset_group_and_aggregate(subsets, group_id, aggregate, data = nil))
  end

  def highest_scoring_visitor
    subsets = {hoa: "away"}
    group = :teamname
    aggregate = :average_goals_scored

    find_max(subset_group_and_aggregate(subsets, group, aggregate, data = nil))
  end

  def highest_scoring_home_team
    subsets = {hoa: "home"}
    group = :teamname
    aggregate = :average_goals_scored

    find_max(subset_group_and_aggregate(subsets, group, aggregate, data = nil))
  end

  def lowest_scoring_visitor
    subsets = {hoa: "away"}
    group = :teamname
    aggregate = :average_goals_scored

    find_min(subset_group_and_aggregate(subsets, group, aggregate, data = nil))
  end

  def lowest_scoring_home_team
    subsets = {hoa: "home"}
    group = :teamname
    aggregate = :average_goals_scored

    find_min(subset_group_and_aggregate(subsets, group, aggregate, data = nil))
  end

  def winningest_team
    subsets = nil
    group_id = :teamname
    aggregate = :winning_percentage

    find_max(subset_group_and_aggregate(subsets, group_id, aggregate, data = nil))
  end

  def best_fans
    subset = nil
    group = :teamname
    agg = :home_vs_away_percent_difference

    find_max(subset_group_and_aggregate(subset, group, agg))
  end

  def worst_fans
    subset = nil
    group = :teamname
    agg = :home_vs_away_percent_difference

    win_percent = subset_group_and_aggregate(subset, group, agg)
    win_percent.find_all do |team, difference|
      difference < 0
    end
  end

end
