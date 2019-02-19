require './test/test_helper'
require './lib/stat_tracker'

class HelpersTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.new()
  end

  def test_subset_data
    full_array = [{a:1, b:2}, {a:1, b:3}, {a:1, b:5}, {a:1, b:6},
                  {a:2, b:4}, {a:2, b:5}, {a:2, b:6}, {a:2, b:6} ]
    expected = [{a:1, b:2}, {a:1, b:3}, {a:1, b:5}, {a:1, b:6}]

    actual = @stat_tracker.subset_data(:a, 1, full_array)

    assert_equal expected, actual
  end

  def test_multi_subset
    full_array = [{a:1, b:2}, {a:1, b:3}, {a:1, b:5}, {a:1, b:6},
                  {a:2, b:4}, {a:2, b:5}, {a:2, b:6}, {a:2, b:6} ]

    expected = [{a:2, b:6}, {a:2, b:6}]
    actual = @stat_tracker.multi_subset({a:2, b:6}, full_array)

    assert_equal expected, actual
  end

  def test_game_grouping
    full_array = [{a:1, b:2}, {a:1, b:3}, {a:1, b:5}, {a:1, b:6},
                  {a:2, b:4}, {a:2, b:5}, {a:2, b:6}, {a:2, b:6} ]

    expected = {1 => [{a:1, b:2}, {a:1, b:3}, {a:1, b:5}, {a:1, b:6}],
                2 => [{a:2, b:4}, {a:2, b:5}, {a:2, b:6}, {a:2, b:6}]}
    actual = @stat_tracker.game_grouping(:a, full_array)

    assert_equal expected, actual
  end

  def test_hash_aggregate
    grouped_info = {1 => [{a:1, goals:2}, {a:1, goals:3}, {a:1, goals:5}, {a:1, goals:6}],
                   2 => [{a:2, goals:4}, {a:2, goals:5}, {a:2, goals:6}, {a:2, goals:6}]}

    expected = {1 => 16, 2 => 21}

    actual = @stat_tracker.hash_aggregate(grouped_info, :total_goals)

    assert_equal expected, actual
  end



end
