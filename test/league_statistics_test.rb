require './test/test_helper'
require './lib/stat_tracker'
require './lib/stat_parser'

class LeagueStatisticsTest < MiniTest::Test

  def setup
    v_small_data_paths = {games: './data/game_very_small.csv',
                          teams: './data/team_info.csv',
                          game_teams: './data/game_teams_stats_very_small.csv'}

    small_data_paths = {games: './data/game_small.csv',
                        teams: './data/team_info.csv',
                        game_teams: './data/game_teams_stats_small.csv'}

    data_paths = {games: './data/game.csv',
                  teams: './data/team_info.csv',
                  game_teams: './data/game_teams_stats.csv'}

    @v_small_data = StatTracker.from_csv(v_small_data_paths)
    @small_data = StatTracker.from_csv(small_data_paths)
    @data = StatTracker.from_csv(data_paths)
  end

  def test_count_of_teams
    assert_equal 2, @v_small_data.count_of_teams
    assert_equal 7, @small_data.count_of_teams
    assert_equal 31, @data.count_of_teams
  end

  def test_best_offense
    assert_equal "Golden Knights", @data.best_offense
    assert_equal "Senators", @small_data.best_offense
    assert_equal "Bruins", @v_small_data.best_offense
  end

  def test_worst_offense
    assert_equal "Sabres", @data.worst_offense
    assert_equal "Penguins", @small_data.worst_offense
    assert_equal "Rangers", @v_small_data.worst_offense
  end


  def test_best_defense
    assert_equal "Kings", @data.best_defense
    assert_equal "Bruins", @small_data.best_defense
    assert_equal "Bruins", @v_small_data.best_defense
  end

  def test_worst_defense
    assert_equal "Sabres", @data.worst_defense
    assert_equal "Canadiens", @small_data.worst_defense
    assert_equal "Rangers", @v_small_data.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Capitals", @data.highest_scoring_visitor
    assert_equal "Bruins", @small_data.highest_scoring_visitor
    assert_equal "Rangers", @v_small_data.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Golden Knights", @data.highest_scoring_home_team
    assert_equal "Senators", @small_data.highest_scoring_home_team
    assert_equal "Bruins", @v_small_data.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Sabres", @data.lowest_scoring_visitor
    assert_equal "Penguins", @small_data.lowest_scoring_visitor
    assert_equal "Rangers", @v_small_data.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Sabres", @data.lowest_scoring_home_team
    assert_equal "Penguins", @small_data.lowest_scoring_home_team
    assert_equal "Bruins", @v_small_data.lowest_scoring_home_team
  end

  def test_winningest_team
    assert_equal "Golden Knights", @data.winningest_team
    assert_equal "Bruins", @small_data.winningest_team
    assert_equal "Bruins", @v_small_data.winningest_team
  end

  def test_best_fans
    assert_equal "Flyers", @data.best_fans
    assert_equal "Rangers", @small_data.best_fans
    assert_equal "Bruins", @v_small_data.best_fans
  end

  def test_worst_fans
    assert_equal [], @data.worst_fans
    assert_equal [], @small_data.worst_fans
    assert_equal [], @v_small_data.worst_fans
  end
end
