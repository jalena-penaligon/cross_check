require './test/test_helper'
require './lib/stat_parser'

class ConversionsTest < MiniTest::Test

    def setup
      @stat_parser = StatParser.new([],[])
    end

    def test_it_can_convert_values_to_boolean
      simple_hash = {won: "False", season:"3", name:"Blackhawks"}

      simple_hash_2 = {won: "True", season:"3", name:"Blackhawks"}
      actual = @stat_parser.convert_won_to_boolean(simple_hash)
      expected = {won:false, season: "3", name: "Blackhawks"}

      actual_2 = @stat_parser.convert_won_to_boolean(simple_hash_2)
      expected_2 = {won:true, season:"3", name:"Blackhawks"}
      assert_equal expected, actual
      assert_equal expected_2, actual_2
    end

    def test_it_can_delete_keys
        simple_hash = {nil=>0, venue_time_zone_id: "A", venue_time_zone_offset: -4,
                    home_rink_side_start: "left", franchiseid: 2, venue_link: "link",
                    venue: "Garden", abbreviation: "NJD", link: "Http",
                    shortname: "NewJersey", away_team_id: 4, home_team_id: 6,
                    outcome: "ShotsOT", shots:5}

        actual = @stat_parser.delete_keys(simple_hash)
        expected = {:franchiseid=>2, :venue_link=>"link", :abbreviation=>"NJD", :shortname=>"NewJersey", shots:5}
        assert_equal expected, actual
    end

end
