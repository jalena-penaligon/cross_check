require './test/test_helper'
require './lib/stat_tracker'
require './lib/stat_parser'
require 'pry'

class GameStatsTest < MiniTest::Test

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

  def test_calcualte_highest_total_score
    assert_equal 7, @v_small_data.highest_total_score
    assert_equal 7, @small_data.highest_total_score
    # assert_equal 15, @data.highest_total_score
  end

  def test_calcualte_lowest_total_score
    assert_equal 5, @v_small_data.lowest_total_score
    assert_equal 1, @small_data.lowest_total_score
    # assert_equal 0, @data.lowest_total_score
  end

  def test_calculate_biggest_blowout
    assert_equal 3, @v_small_data.biggest_blowout
    assert_equal 5, @small_data.biggest_blowout
    # assert_equal 10, @data.biggest_blowout
  end
  #
  # def test_calculate_percentage_home_wins
  #   skip
  # binding.pry
  #
  #   assert_equal 1.0, @v_small_data.percentage_home_wins
  #   assert_equal 0.7, @small_data.percentage_home_wins
  #   assert_equal 0.55, @data.percentage_home_wins
  # end
  #
  # def test_calculate_percentage_visitor_wins
  #   skip
  #
  #   assert_equal 0.0, @v_small_data.percentage_visitor_wins
  #   assert_equal 0.3, @small_data.percentage_visitor_wins
  #   assert_equal 0.45, @data.percentage_visitor_wins
  # end
  #
  # def test_calculate_total_games_by_season
  #   skip
  #
  #   expected = {20122013: 2}
  #   assert_equal expected, @v_small_data.count_of_games_by_season
  #
  #   expected = {20122013: 20}
  #   assert_equal expected, @small_data.count_of_games_by_season
  #
  #   expected = {
  #     20122013: 806
  #     20122013: 1323
  #     20122013: 1319
  #     20122013: 1321
  #     20122013: 1317
  #     20122013: 1355
  #   }
  #   assert_equal expected, @data.count_of_games_by_season
  # end
  #
  # def test_calculate_average_goals_per_game
  #   skip
  #   assert_equal 6.0, @v_small_data.average_goals_per_game
  #   assert_equal 6.0, @small_data.average_goals_per_game
  #   assert_equal 6.0, @data.average_goals_per_game
  # end
  #
  # def test_calculate_average_goals_per_season
  #   skip
  #   expected = {20122013: 6.0}
  #   assert_equal expected, @v_small_data.average_goals_by_season
  #
  #   expected = {20122013: 4.65}
  #   assert_equal expected, @small_data.average_goals_by_season
  #
  #   expected = {20122013: 5.44}
  #   assert_equal expected, @data.average_goals_by_season
  # end
end
