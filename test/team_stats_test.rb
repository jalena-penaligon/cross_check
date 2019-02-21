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
      @data = StatTracker.from_csv(data_paths)
    end

  def test_team_info_with_respective_team_attributes
    expected = {
                "team_id" =>"3",
                "franchise_id" =>"10",
                "short_name"=> "NY Rangers",
                "team_name" =>"Rangers",
                "abbreviation" =>"NYR",
                "link"=>"/api/v1/teams/3"
                }
    assert_equal expected, @v_small_data.team_info("3")

    expected = {
                "team_id"=> "16",
                "franchise_id"=> "11",
                "short_name"=> "Chicago",
                "team_name"=> "Blackhawks",
                "abbreviation"=> "CHI",
                "link"=> "/api/v1/teams/16"
                }
    assert_equal expected, @small_data.team_info("16")

    expected = {
                "team_id"=> "18",
                "franchise_id"=> "34",
                "short_name"=> "Nashville",
                "team_name"=> "Predators",
                "abbreviation"=> "NSH",
                "link"=> "/api/v1/teams/18"
                }
    assert_equal expected, @data.team_info("18")
  end

  def test_best_season
    assert_equal "20122013", @v_small_data.best_season("6")
    assert_equal "20122013", @small_data.best_season("5")
    assert_equal "20142015", @data.best_season("8")
  end

  def test_worst_season
    assert_equal "20122013", @v_small_data.worst_season("3")
    assert_equal "20122013", @small_data.worst_season("16")
    assert_equal "20142015", @data.worst_season("5")
  end

  def test_average_win_percentage
    assert_equal 1.0, @v_small_data.average_win_percentage("6")
    assert_equal 0.75, @small_data.average_win_percentage("9")
    assert_equal 0.52, @data.average_win_percentage("18")
  end

  def test_most_goals_scored
    assert_equal 2, @v_small_data.most_goals_scored("3")
    assert_equal 4, @small_data.most_goals_scored("17")
    assert_equal 8, @data.most_goals_scored("2")
  end

  def test_fewest_goals_scored
    assert_equal 3, @v_small_data.fewest_goals_scored("6")
    assert_equal 1, @small_data.fewest_goals_scored("8")
    assert_equal 0, @data.fewest_goals_scored("7")
  end

  def test_favorite_opponent
    assert_equal "Bruins", @v_small_data.favorite_opponent("3")
    assert_equal "Bruins", @small_data.favorite_opponent("5")
    assert_equal "Coyotes", @data.favorite_opponent("12")
  end

  def test_rival
    assert_equal "Rangers", @v_small_data.rival("6")
    assert_equal "Bruins", @small_data.rival("3")
    assert_equal "Blackhawks", @data.rival("5")
  end

  def test_biggest_team_blowout
    assert_equal 3, @v_small_data.biggest_team_blowout("6")
    assert_equal 3, @small_data.biggest_team_blowout("16")
    assert_equal 8, @data.biggest_team_blowout("24")
  end

  def test_worst_loss
    assert_equal 3, @v_small_data.worst_loss("3")
    assert_equal 3, @small_data.worst_loss("17")
    assert_equal 6, @data.worst_loss("18")
  end

  def test_head_to_head
    expected = {"Rangers" => 1.0}
    assert_equal expected, @v_small_data.head_to_head("6")

    expected = {
                "Penguins" => 1.0,
                "Rangers" => 0.8,
                }
    assert_equal expected, @small_data.head_to_head("6")

    expected = {
      "Blues" => 0.47,
      "Jets" => 0.55,
      "Avalanche" => 0.63,
      "Flames" => 0.44,
      "Red Wings" => 0.29,
      "Blue Jackets" => 0.6,
      "Stars" => 0.52,
      "Blackhawks" => 0.42,
      "Wild" => 0.44,
      "Devils" => 0.5,
      "Canadiens" => 0.6,
      "Canucks" => 0.5,
      "Rangers" => 0.4,
      "Lightning" => 0.7,
      "Capitals" => 0.7,
      "Sharks" => 0.6,
      "Oilers" => 0.78,
      "Ducks" => 0.48,
      "Penguins" => 0.31,
      "Islanders" => 0.4,
      "Kings" => 0.61,
      "Sabres" => 0.7,
      "Coyotes" => 0.67,
      "Bruins" => 0.5,
      "Panthers" => 0.5,
      "Maple Leafs" => 0.4,
      "Senators" => 0.7,
      "Hurricanes" => 0.3,
      "Golden Knights" => 0.33,
      "Flyers" => 0.5
    }
    assert_equal expected, @data.head_to_head("18")
  end

  def test_seasonal_summary
    expected = {
      "20162017" => {
        preseason: {
          :win_percentage=>0.64,
          :total_goals_scored=>60,
          :total_goals_against=>48,
          :average_goals_scored=>2.73,
          :average_goals_against=>2.18},
          :regular_season => {
            :win_percentage=>0.5,
            :total_goals_scored=>240,
            :total_goals_against=>224,
            :average_goals_scored=>2.93,
            :average_goals_against=>2.73
          }
        },
        "20172018" => {
          preseason: {
            :win_percentage=>0.54,
            :total_goals_scored=>41,
            :total_goals_against=>42,
            :average_goals_scored=>3.15,
            :average_goals_against=>3.23
          },
          :regular_season=>
          {:win_percentage=>0.65,
            :total_goals_scored=>267,
            :total_goals_against=>211,
            :average_goals_scored=>3.26,
            :average_goals_against=>2.57
          }
        },
        "20132014" => {
          preseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.46,
            :total_goals_scored=>216,
            :total_goals_against=>242,
            :average_goals_scored=>2.63,
            :average_goals_against=>2.95
          }
        },
        "20122013" => {
          preseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.33,
            :total_goals_scored=>111,
            :total_goals_against=>139,
            :average_goals_scored=>2.31,
            :average_goals_against=>2.9
          }
        },
        "20142015" => {
          preseason: {
            :win_percentage=>0.33,
            :total_goals_scored=>21,
            :total_goals_against=>19,
            :average_goals_scored=>3.5,
            :average_goals_against=>3.17
          },
          :regular_season=>
          {
            :win_percentage=>0.57,
            :total_goals_scored=>232,
            :total_goals_against=>208,
            :average_goals_scored=>2.83,
            :average_goals_against=>2.54
          }
        },
        "20152016" => {
          preseason: {
            :win_percentage=>0.5,
            :total_goals_scored=>31,
            :total_goals_against=>43,
            :average_goals_scored=>2.21,
            :average_goals_against=>3.07
          },
          :regular_season=>
          {
            :win_percentage=>0.5,
            :total_goals_scored=>228,
            :total_goals_against=>215,
            :average_goals_scored=>2.78,
            :average_goals_against=>2.62
          }
        }
      }
      
    assert_equal expected, @data.seasonal_summary("18")
  end
end
