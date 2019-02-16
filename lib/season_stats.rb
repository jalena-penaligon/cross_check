module SeasonStats

  def biggest_bust
    # team with biggest decrease between "R" and "P"

  end

  def biggest_surprise
    # team with biggest increase betwee "R" and "P"
  end

  def winningest_coach
    # coach with highest win pct for season
  end

  def worst_coach
    # coach with lowest win pct for season
  end

  def most_accurate_team
    # name of team w/ best shoot pct
  end

  def least_accurate_team
    # name of team w/ worst shoot pct
  end

  def most_hits
    # name of team with most hits in season
  end

  def least_hits(season)
    # name of team with least hits in season
    games = find_season_games(season)

  end

  def power_play_goal_percentage(season)
    # percentage of goals that were Power play goals (to 100ths)
    games = find_season_games(season)
    powerplaygoals = games.sum{ |hash| hash[:powerplaygoals]}
    total_goals = games.sum{ |hash| hash[:goals]}
    return (powerplaygoals.to_f / total_goals).round(2)
  end

  def aggregate_stats_by_team

  end

  def find_season_games(season)
    season = season.to_i
    return @data.find_all{ |hash| hash[:season] == season}
  end

end

class SSTest<MiniTest::Test

  def test_it_can_find_season_games
    simple_games_hash = [
      {season: 1, game_id: 1},
      {season: 1, game_id: 2},
      {season: 1, game_id: 3},
      {season: 1, game_id: 4},
      {season: 2, game_id: 5},
      {season: 2, game_id: 6},
      {season: 2, game_id: 7},
      {season: 2, game_id: 8}
    ]

    stat_tracker = StatTracker.new

    expected = [
      {season: 1, game_id: 1},
      {season: 1, game_id: 2},
      {season: 1, game_id: 3},
      {season: 1, game_id: 4}
    ]

    actual = stat_tracker.fins_season_games(1)
    assert_equal expected, actual
  end
end
