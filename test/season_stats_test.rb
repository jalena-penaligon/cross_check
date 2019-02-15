require './test/test_helper'
require './lib/stat_tracker'
require './lib/stat_parser'
require 'pry'

class SeasonStatsTest < MiniTest::Test

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

  def test_biggest_bust
    assert_equal "Blackhawks", @data.biggest_bust("20142015")
    assert_equal "Kings", @data.biggest_bust("20132014")
  end

  def test_biggest_surprise
    assert_equal "Lightning", @data.biggest_surprise("20132014")
    assert_equal "Jets", @data.biggest_surprise("20142015")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @data.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @data.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @data.worst_coach("20132014")
    assert_equal "Craig MacTavish", @data.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal , @v_small_data.most_accurate_team
    assert_equal , @small_data.most_accurate_team
    assert_equal , @data.most_accurate_team
  end

  def test_least_accurate_team
    #Name of the Team with the worst ratio of shots to goals for the season
    #String return.
    assert_equal , @v_small_data.least_accurate_team
    assert_equal , @small_data.least_accurate_team
    assert_equal , @data.least_accurate_team
  end

  def test_most_hits
    #Name of the Team with the most hits in the season
    #String return.
    assert_equal , @v_small_data.most_hits
    assert_equal , @small_data.most_hits
    assert_equal , @data.most_hits
  end

  def test_least_hits
    #	Name of the Team with the least hits in the season
    #String return.
    assert_equal , @v_small_data.least_hits
    assert_equal , @small_data.least_hits
    assert_equal , @data.least_hits
  end

  def test_power_play_goal_percentage
    #Percentage of goals that were power play goals for the season (rounded to the nearest 100th)
    #Float return.
    assert_equal , @v_small_data.power_play_goal_percentage
    assert_equal , @small_data.power_play_goal_percentage
    assert_equal , @data.power_play_goal_percentage
  end
end
