require './test/test_helper'
require './lib/stat_tracker'
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
      # @data = StatTracker.from_csv(data_paths)
    end

  def test_team_info_with_respective_team_attributes
    expected = {
                team_id: 3,
                franchise_id: 10,
                short_name: "NY Rangers",
                team_name: "Rangers",
                abbreviation: "NYR",
                link: "/api/v1/teams/3"
                }
    assert_equal expected, @v_small_data.team_info(3)

    expected = {
                team_id: 16,
                franchise_id: 11,
                short_name: "Chicago",
                team_name: "Blackhawks",
                abbreviation: "CHI",
                link: "/api/v1/teams/16"
                }
    assert_equal expected, @small_data.team_info(16)

    # expected = {
    #             team_id: 18,
    #             franchise_id: 34,
    #             short_name: "Nashville",
    #             team_name: "Predators",
    #             abbreviation: "NSH",
    #             link: "/api/v1/teams/18"
    #             }
    # assert_equal expected, @data.team_info(18)
  end

  def test_count_team_games_by_season
    expected = {20122013 => 7}
    assert_equal expected, @small_data.games_per_season(16)

    expected = {20122013 => 2}
    assert_equal expected, @v_small_data.games_per_season(6)
  end

  def test_count_team_wins_by_season
    expected = {20122013 => 4}
    assert_equal expected, @small_data.wins_per_season(16)

    expected = {20122013 => 2}
    assert_equal expected, @v_small_data.wins_per_season(6)
  end

  def test_calculate_team_win_percentage_by_season
    expected = {20122013 => 0.571}
    assert_equal expected, @small_data.win_percentage_by_season(16)

    expected = {20122013 => 1.0}
    assert_equal expected, @v_small_data.win_percentage_by_season(6)
  end

  def test_best_season
    assert_equal 20122013, @v_small_data.best_season(6)
    assert_equal 20122013, @small_data.best_season(16)
    # assert_equal 20142015, @data.best_season(8)
  end

  def test_worst_season
    assert_equal 20122013, @v_small_data.worst_season(6)
    assert_equal 20122013, @small_data.worst_season(16)
    # assert_equal 20142015, @data.worst_season(5)
  end

  def test_average_win_percentage
    assert_equal 1.0, @v_small_data.average_win_percentage(6)
    assert_equal 0.75, @small_data.average_win_percentage(9)
    # assert_equal 0.447, @data.average_win_percentage(21)
  end

  def test_most_goals_scored
    assert_equal 2, @v_small_data.most_goals_scored(3)
    assert_equal 4, @small_data.most_goals_scored(17)
  end

  def test_fewest_goals_scored
    assert_equal 3, @v_small_data.fewest_goals_scored(6)
    assert_equal 1, @small_data.fewest_goals_scored(8)
    # assert_equal 0, @data.fewest_goals_scored(7)
  end

  def test_count_games_played_against_each_opponent
    expected = {"Bruins" => 2}
    assert_equal expected, @v_small_data.games_by_opponent(3)

    expected = {"Rangers" => 5, "Penguins" => 4}
    assert_equal expected, @small_data.games_by_opponent(6)
  end

  def test_count_wins_against_each_opponent
    expected = {"Rangers" => 2}
    assert_equal expected, @v_small_data.wins_by_opponent(6)

    expected = {"Rangers" => 4, "Penguins" => 4}
    assert_equal expected, @small_data.wins_by_opponent(6)
  end

  def test_calculate_win_percentage_against_each_opponent
    expected = {"Rangers" => 1.0}
    assert_equal expected, @v_small_data.win_percentage_by_opponent(6)

    expected = {"Rangers" => 0.8, "Penguins" => 1.0}
    assert_equal expected, @small_data.win_percentage_by_opponent(6)
  end

  def test_favorite_opponent
    assert_equal "Rangers", @v_small_data.favorite_opponent(6)
    assert_equal "Penguins", @small_data.favorite_opponent(6)
    # assert_equal "Coyotes", @data.favorite_opponent(12)
  end

  def test_rival
    assert_equal "Rangers", @v_small_data.rival(6)
    assert_equal "Bruins", @small_data.rival(3)
    # assert_equal "Blackhawks", @data.rival(5)
  end

  def test_calculate_goal_difference_by_each_game
    # binding.pry
    expected = {2012030221 => -1, 2012030222 => -3}
    assert_equal expected, @v_small_data.goal_difference_by_game(3)

    expected = {
      2012030121 => 2,
      2012030122 => -2,
      2012030123 => 5,
      2012030124 => 1
    }
    assert_equal expected, @small_data.goal_difference_by_game(9)
  end

  def test_biggest_team_blowout
    assert_equal 3, @v_small_data.biggest_team_blowout(6)
    assert_equal 3, @small_data.biggest_team_blowout(16)
    # assert_equal 8, @data.biggest_team_blowout(24)
  end

  def test_worst_loss
    assert_equal -3, @v_small_data.worst_loss(3)
    assert_equal -3, @small_data.worst_loss(17)
    # assert_equal -7, @data.worst_loss(27)
  end
#
#   def test_head_to_head
#     expected = {"Rangers" => 1.0}
#     assert_equal expected, @v_small_data.head_to_head(6)
#
#     expected = {
#                 "Penguins" => 1.0,
#                 "Rangers" => 0.8,
#                 }
#     assert_equal expected, @small_data.head_to_head(6)
#
#     expected = {
#       "Blackhawks" => 0.53,
#       "Blue Jackets" => 0.46,
#       "Blues" => 0.37,
#       "Bruins" => 0.7,
#       "Canadians" => 0.5,
#       "Canucks" => 0.42,
#       "Capitals" => 0.3,
#       "Coyotes" => 0.56,
#       "Devils" => 0.7,
#       "Ducks" => 0.39,
#       "Flames" => 0.42,
#       "Flyers" => 0.4,
#       "Golden Knights" => 0.33,
#       "Hurricanes" => 0.5,
#       "Islanders" => 0.5,
#       "Jets" => 0.5,
#       "Kings" => 0.28,
#       "Lightning" => 0.4,
#       "Maple Leafs" => 0.5,
#       "Oilers" => 0.4,
#       "Panthers" => 0.5,
#       "Penguins" => 0.5,
#       "Predators" => 0.38,
#       "Rangers" => 0.5,
#       "Red Wings" => 0.46,
#       "Sabres" => 0.7,
#       "Senators" => 0.4,
#       "Sharks" => 0.39,
#       "Stars" => 0.59,
#       "Wild" => 0.42,
#     }
#     assert_equal expected, @data.head_to_head(21)
#   end
#
#   def test_seasonal_summary
#     expected = {
#                 20122013 => {
#                   preseason: {
#                               win_percentage:
#                               total_goals_scored:
#                               total_goals_against:
#                               average_goals_scored:
#                               average_goals_against:
#                               }
#                   regular_season:{
#                                   win_percentage:
#                                   total_goals_scored:
#                                   total_goals_against:
#                                   average_goals_scored:
#                                   average_goals_against:
#                                   }
#                                 }
#                               }
#     assert_equal expected, @data.seasonal_summary(3)
#   end
end
