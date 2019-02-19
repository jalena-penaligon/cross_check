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
    assert_equal "Claude Julien", @v_small_data.winningest_coach("20122013")
    assert_equal "Claude Julien", @small_data.winningest_coach("20122013")
    assert_equal "Claude Julien", @data.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @data.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @v_small_data.worst_coach("20122013")
    assert_equal "Dan Bylsma", @small_data.worst_coach("20122013")
    assert_equal "Peter Laviolette", @data.worst_coach("20132014")
    assert_equal "Craig MacTavish", @data.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal "Bruins", @v_small_data.most_accurate_team("20122013")
    assert_equal "Senators", @small_data.most_accurate_team("20122013")
    assert_equal "Stars", @data.most_accurate_team("20152016")
  end

  def test_least_accurate_team
    assert_equal "Rangers", @v_small_data.least_accurate_team("20122013")
    assert_equal "Penguins", @small_data.least_accurate_team("20122013")
    assert_equal "Avalanche", @data.least_accurate_team("20162017")
  end

  def test_most_hits
    assert_equal "Bruins", @v_small_data.most_hits("20122013")
    assert_equal "Bruins", @small_data.most_hits("20122013")
    assert_equal "Kings", @data.most_hits("20132014")
  end

  def test_least_hits
    assert_equal "Rangers", @v_small_data.least_hits("20122013")
    assert_equal "Penguins", @small_data.least_hits("20122013")
    assert_equal "Canucks", @data.least_hits("20152016")
  end

  def test_power_play_goal_percentage
    assert_equal 0.08, @v_small_data.power_play_goal_percentage("20122013")
    assert_equal 0.17, @small_data.power_play_goal_percentage("20122013")
    assert_equal 0.21, @data.power_play_goal_percentage("20172018")
  end
end
