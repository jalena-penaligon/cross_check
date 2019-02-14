require './test/test_helper'
require './lib/stat_parser'

class ConversionsTest < MiniTest::Test

    def setup
      @stat_parser = StatParser.new([],[])
    end

    def test_it_can_convert_values_to_boolean
      simple_hash = {won: "False", season:"3", name:"Blackhawks"}

      actual = @stat_parser.convert_won_to_boolean(simple_hash)
      expected = {won:false, season: "3", name: "Blackhawks"}
      assert_equal expected, actual
    end

    def test_it_can_delete_keys
        simple_hash = {nil => 0, link:3, shots:5}

        actual = @stat_parser.delete_keys(simple_hash)
        expected = {shots:5}
        assert_equal expected, actual
    end

end
