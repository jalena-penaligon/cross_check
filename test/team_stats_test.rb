require './test/test_helper'
require './lib/stat_tracker'
require './lib/stat_parser'
require 'pry'

class TeamStatsTest < Minitest::Test

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

  def test_team_info_with_respective_team_attributes

  end

  def test_best_season
    assert_equal 20122013, @v_small_data.best_season(6)
    assert_equal 20122013, @small_data.best_season(5)
    assert_equal 20142015, @data.best_season(8)
  end

  def test_worst_season
    assert_equal 20122013, @v_small_data.worst_season(3)
    assert_equal 20122013, @small_data.worst_season(16)
    assert_equal 20142015, @data.worst_season(5)
  end

  def test_average_win_percentage
    assert_equal 1.0, @v_small_data.average_win_percentage(6)
    assert_equal 0.75, @small_data.average_win_percentage(9)
    assert_equal 0.447, @data.average_win_percentage(21)
  end

  def test_most_goals_scored
    assert_equal 2, @v_small_data.most_goals_scored(3)
    assert_equal 4, @small_data.most_goals_scored(17)
    assert_equal 8, @data.most_goals_scored(2)
  end

  def test_fewest_goals_scored
    assert_equal 3, @v_small_data.fewest_goals_scored(6)
    assert_equal 1, @small_data.fewest_goals_scored(8)
    assert_equal 0, @data.fewest_goals_scored(7)
  end

  def test_favorite_opponent
    assert_equal "Bruins", @v_small_data.favorite_opponent(3)
    assert_equal "Bruins", @small_data.favorite_opponent(5)
    assert_equal "Coyotes", @data.favorite_opponent(12)
  end

  def test_rival
    assert_equal "Rangers", @v_small_data.rival(6)
    assert_equal "Bruins", @small_data.rival(3)
    assert_equal "Blackhawks", @data.rival(5)
  end

  def test_biggest_team_blowout
    assert_equal 3, @v_small_data.biggest_team_blowout(6)
    assert_equal 3, @small_data.biggest_team_blowout(16)
    assert_equal 8, @data.biggest_team_blowout(24)
  end

  def test_worst_loss
    assert_equal -3, @v_small_data.worst_loss(3)
    assert_equal -3, @small_data.worst_loss(17)
    assert_equal -7, @data.worst_loss(27)
  end
end
