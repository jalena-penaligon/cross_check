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
    # @data = StatTracker.from_csv(data_paths)
  end

  def test_count_of_teams
    assert_equal 2, @v_small_data.count_of_teams
    assert_equal 7, @small_data.count_of_teams
    # assert_equal 32, @data.count_of_teams
  end

  def test_count_games_played_per_team
    expected = {"Rangers"=>5, "Bruins"=>9, "Penguins"=>4, "Red Wings"=>7, "Blackhawks"=>7, "Senators"=>4, "Canadiens"=>4}
    assert_equal expected, @small_data.games_per_team

    expected = {"Rangers"=>2, "Bruins"=>2}
    assert_equal expected, @v_small_data.games_per_team
  end

  def test_sum_goals_for_all_teams
    expected = {"Rangers"=>10, "Bruins"=>28, "Penguins"=>2, "Red Wings"=>15, "Blackhawks"=>16, "Senators"=>14, "Canadiens"=>8}
    assert_equal expected, @small_data.total_team_goals

    expected = {"Rangers"=>4, "Bruins"=>8}
    assert_equal expected, @v_small_data.total_team_goals
  end

  def test_best_offense
    # assert_equal "Golden Knights", @data.best_offense
    assert_equal "Senators", @small_data.best_offense
    assert_equal "Bruins", @v_small_data.best_offense
  end

  def test_worst_offense
    # assert_equal "Sabres", @data.worst_offense
    assert_equal "Penguins", @small_data.worst_offense
    assert_equal "Rangers", @v_small_data.worst_offense
  end

  def test_sum_oppontent_goals_for_all_teams
    expected = {"Rangers"=>16, "Bruins"=>12, "Penguins"=>12, "Red Wings"=>16, "Blackhawks"=>15, "Senators"=>8, "Canadiens"=>14}
    assert_equal expected, @small_data.goals_allowed

    expected = {"Rangers"=>8, "Bruins"=>4}
    assert_equal expected, @v_small_data.goals_allowed
  end

  # def test_best_defense
  #   skip
  #   assert_equal "Kings", @data.best_defense
  #   assert_equal "Bruins", @small_data.best_defense
  #   assert_equal "Bruins", @v_small_data.best_defense
  # end
  #
  # def test_worst_defense
  #   skip
  #   assert_equal 0, @data.worst_defense
  #   assert_equal 0, @small_data.worst_defense
  #   assert_equal 0, @v_small_data.worst_defense
  # end
  #
  # def test_highest_scoring_visitor
  #   skip
  #   assert_equal "Capitals", @data.highest_scoring_visitor
  #   assert_equal "Bruins", @small_data.highest_scoring_visitor
  #   assert_equal "Rangers", @v_small_data.highest_scoring_visitor
  # end
  #
  # def test_highest_scoring_home_team
  #   skip
  #   assert_equal "Golden Knights", @data.highest_scoring_home_team
  #   assert_equal "Senators", @small_data.highest_scoring_home_team
  #   assert_equal "Bruins", @v_small_data.highest_scoring_home_team
  # end
  #
  # def test_lowest_scoring_visitor
  #   skip
  #   assert_equal "Sabres", @data.lowest_scoring_visitor
  #   assert_equal "Penguins", @small_data.lowest_scoring_visitor
  #   assert_equal "Rangers", @v_small_data.lowest_scoring_visitor
  # end
  #
  # def test_lowest_scoring_home_team
  #   skip
  #   assert_equal "Sabres", @data.lowest_scoring_home_team
  #   assert_equal "Penguins", @small_data.lowest_scoring_home_team
  #   assert_equal "Bruins", @v_small_data.lowest_scoring_home_team
  # end
  #
  # def test_winningest_team
  #   skip
  #   assert_equal "Golden Knights", @data.winningest_team
  #   assert_equal "Bruins", @small_data.winningest_team
  #   assert_equal "Bruins", @v_small_data.winningest_team
  # end
  #
  # def test_best_fans
  #   skip # Need to Check aggregations
  #   assert_equal "Flyers", @data.best_fans
  #   assert_equal "Senators", @small_data.best_fans
  #   assert_equal "Bruins", @v_small_data.best_fans
  # end
  #
  # def test_worst_fans
  #   skip # Need to Check aggregations
  #   assert_equal [], @data.worst_fans
  #   assert_equal [], @small_data.worst_fans
  #   assert_equal [], @v_small_data.worst_fans
  # end
end
