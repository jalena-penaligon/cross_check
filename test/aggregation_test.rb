class AggregationTests < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.new
    @game_list = [{game_id: 1, shots: 30, goals: 3, hits:15, won:true},
                  {game_id: 2, shots: 28, goals: 4, hits:17, won:true}
                  {game_id: 3, shots: 35, goals: 5, hits:18, won:false}
                  {game_id: 4, shots: 20, goals: 2, hits:19, won:false}
                  {game_id: 5, shots: 33, goals: 3, hits:13, won:true}]
  end

  def test_winning_percentage
    assert_equal 0.4, @stat_trackerwinning_percentage(@game_list)
  end

  def test_total_shots
    assert_equal 146, @stat_tracker.total_shots(@game_list)
  end

  def test_total_goals
    assert_equal 17, @stat_tracker.total_goals(@game_list)
  end

  def test_total_hits
    assert_equal 82, @stat_tracker.total_hits(@game_list)
  end

  def test_total_wins
    assert_equal 3, @stat_tracker.total_wins(@game_list)
  end

  def test_total_games
    assert_equal 5, @stat_tracker.total_games(@game_list)
  end

  def test_shooting_percentage
    assert_equal 0.12, @stat_tracker.shooting_percentage(@game_list).round(2)
  end

  def test_win_percentage_difference
    games = [{game_id: 1, shots: 30, goals: 3, hits:15, won:true, type: "P"},
              {game_id: 2, shots: 28, goals: 4, hits:17, won:true, type: "P"}
              {game_id: 3, shots: 35, goals: 5, hits:18, won:false, type: "P"}
              {game_id: 4, shots: 20, goals: 2, hits:19, won:false, type: "R"}
              {game_id: 5, shots: 33, goals: 3, hits:13, won:true, type: "R"}]
    assert_equal 0.17, @stat_tracker.win_percentage_difference(games).round(2)
  end
end
