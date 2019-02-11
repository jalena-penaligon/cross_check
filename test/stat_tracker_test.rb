require './test/test_helper'
require './lib/stat_tracker_test.rb'

class StatTrackerTest < MiniTest::Test
  def test_it_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end
end
