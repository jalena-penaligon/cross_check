require './test/test_helper'
require './lib/stat_parser'

class ConversionsTest < MiniTest::Test

    def setup
      @stat_parser = StatParser.new([],[])
    end
    
    def test_it_can_convert_values_to_boolean
      simple_hash = {won: "False", season:"3", name:"Blackhawks"}

      actual = @stat_parser.convert_to_boolean(simple_hash)
      expected = {won:false, season: "3", name: "Blackhawks"}
      assert_equal expected, actual
    end

    def test_it_can_convert_values_to_int
      simple_hash = {game_id: "0", season:"3", shots:"5", name:"Blackhawks"}

      actual = @stat_parser.convert_to_int(simple_hash)
      expected = {game_id: 0, shots: 5, season: 3, name: "Blackhawks"}
      assert_equal expected, actual
    end

    def test_it_can_convert_values_to_floats
      simple_hash = { faceoffwinpercentage:"52.5", shots:"5", name:"Blackhawks"}

      actual = @stat_parser.convert_to_float(simple_hash)
      expected = {faceoffwinpercentage:52.5, shots: "5", name: "Blackhawks"}
      assert_equal expected, actual
    end

    def test_it_can_delete_keys
        simple_hash = {nil => 0, link:3, shots:5}

        actual = @stat_parser.delete_keys(simple_hash)
        expected = {shots:5}
        assert_equal expected, actual
    end

end
