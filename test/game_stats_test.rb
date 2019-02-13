require './test/test_helper'
require './lib/stat_tracker'
require './lib/stat_parser'

class GameStatsTest < MiniTest::Test

  def test_calcualte_highest_total_score
    stat_tracker = StatTracker.new

    assert_equal 7, stat_tracker.highest_total_score
  end

  def test_calcualte_lowest_total_score
    stat_tracker = StatTracker.new

    assert_equal 5, stat_tracker.lowest_total_score
  end

  def test_calculate_biggest_blowout
    stat_tracker = StatTracker.new

    assert_equal 3, stat_tracker.biggest_blowout
  end

  def test_calculate_percentage_home_wins
    stat_tracker = StatTracker.new

    assert_equal 1.0, stat_tracker.percentage_home_wins
  end

  def test_calculate_percentage_visitor_wins
    stat_tracker = StatTracker.new

    assert_equal 0.0, stat_tracker.percentage_visitor_wins
  end

  def test_calculate_total_games_by_season
    stat_tracker = StatTracker.new
    expected = {20122013: 2}

    assert_equal expected, stat_tracker.count_of_games_by_season
  end

  def test_calculate_average_goals_per_game
    stat_tracker = StatTracker.new

    assert_equal 6.0, stat_tracker.average_goals_per_game
  end

  def test_calculate_average_goals_per_season
    stat_tracker = StatTracker.new
    expected = {20122013: 6.0}

    assert_equal expected, stat_tracker.average_goals_by_season
  end
end 
