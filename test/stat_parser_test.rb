require './test/test_helper'
require './lib/stat_parser'

class StatParserTest < MiniTest::Test

  def setup
    @game_data = [
      {game_id: "2012030221", season: "20122013", type: 'P', date_time: '2013-05-16',
        away_team_id: "3", home_team_id: "6", away_goals: "2", home_goals: "3",
        outcome: 'home win OT', home_rink_side_start: 'left', venue: 'TD Garden',
        venue_time_zone_id: 'America/New_York', venue_time_zone_offset: "-4",
        venue_time_zone_tz: 'EDT'},
      {game_id: "2012030222", season: "20122013", type: 'P', date_time: '2013-05-19',
        away_team_id: "3", home_team_id: "6", away_goals: "2", home_goals: "5",
        outcome: 'home win REG', home_rink_side_start: 'left', venue: 'TD Garden',
        venue_time_zone_id: 'America/New_York', venue_time_zone_offset: "-4",
        venue_time_zone_tz: 'EDT'}
    ]

    @game_team_data = [
      {game_id: "2012030221", team_id: "3", hoa: 'away', won: "False", settled_in: 'OT',
        head_coach: 'John Tortorella', goals: "2", shots: "35", hits: "44", pim: "8",
        powerplayopportunities: "3", powerplaygoals: "0", faceoffwinpercentage: "44.8",
        giveaways: "17", takeaways: "7"},
      {game_id: "2012030221", team_id: "6", hoa: 'home', won: "True", settled_in: 'OT',
        head_coach: 'Claude Julien', goals: "3", shots: "48", hits: "51", pim: "6",
        powerplayopportunities: "4", powerplaygoals: "1", faceoffwinpercentage: "55.2",
        giveaways: "4", takeaways: "5"},
      {game_id: "2012030222", team_id: "3", hoa: 'away', won: "False", settled_in: 'REG',
        head_coach: 'John Tortorella', goals: "2", shots: "37", hits: "33", pim: "11",
        powerplayopportunities: "5", powerplaygoals: "0", faceoffwinpercentage: "51.7",
        giveaways: "1", takeaways: "4"},
      {game_id: "2012030222", team_id: "6", hoa: 'home', won: "True", settled_in: 'REG',
        head_coach: 'Claude Julien', goals: "5", shots: "32", hits: "36", pim: "19",
        powerplayopportunities: "1", powerplaygoals: "0", faceoffwinpercentage: "48.3",
        giveaways: "16", takeaways: "6"}
    ]

    @team_info_data = [{team_id: "6", franchiseid: "6",  shortname: 'Boston',
                        teamname: 'Bruins', abbreviation: 'BOS'},
                       {team_id: "3",  franchiseid: "10",  shortname: 'NY Rangers',
                      teamname: 'Rangers',  abbreviation: 'NYR'}]
    @stat_parser = StatParser.new([@game_team_data, @game_data, @team_info_data],
                                  [:game_id, :team_id])
  end


  def test_it_exists
    assert_instance_of StatParser, @stat_parser
  end

  def test_find_hash_to_merge
    hash_to_merge = {id: 1, t:1, s:3}
    merge_from_array = [{id:1, v:6},{id:2,v:5}]
    merge_key = :id

    expected = {id:1, v:6}
    actual = @stat_parser.find_hash_to_merge(hash_to_merge, merge_from_array, merge_key)

    assert_equal expected, actual
  end

  def test_merge_hash_arrays
    merge_to_array = [{id: 1, t:1, s:3}, {id:2, t:4, s:5}]
    merge_from_array = [{id:1, v:6},{id:2,v:5}]
    merge_key = :id

    expected = [{id: 1, t:1, s:3, v:6}, {id:2, t:4, s:5, v:5}]
    actual = @stat_parser.merge_hash_arrays(merge_to_array, merge_from_array, merge_key)

    assert_equal expected, actual
  end

  def test_it_has_merged_data
    skip
    expected_data = [ {game_id: 2012030221,  team_id: 3,  hoa: "away",  won: false,
      settled_in: "OT",  head_coach: "John Tortorella",  goals: 2,  shots: 35,
      hits: 44,  pim: 8,  powerplayopportunities: 3,  away_goals: 2,  home_goals: 3,
      powerplaygoals: 0,  faceoffwinpercentage: 44.8,  giveaways: 17,  takeaways: 7,
      season: 20122013,  type: "P",  date_time: "2013-05-16",  venue_time_zone_tz: "EDT",
      teamname: "Rangers"}, {game_id: 2012030222,  team_id: 3,  hoa: "away",
      won: false,  settled_in: "REG",  head_coach: "John Tortorella",  goals: 2,
      shots: 37,  hits: 33,  pim: 11,  powerplayopportunities: 5,  away_goals: 2,
      home_goals: 5,  powerplaygoals: 0,  faceoffwinpercentage: 51.7,
      giveaways: 1,  takeaways: 4,  season: 20122013,  type: "P",
      date_time: "2013-05-19",  venue_time_zone_tz: "EDT",  teamname: "Rangers"},
      {game_id: 2012030221,  team_id: 6,  hoa: "home",  won: true,  settled_in: "OT",
      head_coach: "Claude Julien",  goals: 3,  shots: 48,  hits: 51,  pim: 6,
      powerplayopportunities: 4,  away_goals: 2,  home_goals: 3,
      powerplaygoals: 1,  faceoffwinpercentage: 55.2,  giveaways: 4,  takeaways: 5,
      season: 20122013,  type: "P",  date_time: "2013-05-16",
      venue_time_zone_tz: "EDT",  teamname: "Bruins"},
      {game_id: 2012030222,  team_id: 6,  hoa: "home",  won: true,  settled_in: "REG",
      head_coach: "Claude Julien",  goals: 5,  shots: 32,  hits: 36,  pim: 19,
      powerplayopportunities: 1,  away_goals: 2,  home_goals: 5,  powerplaygoals: 0,
      faceoffwinpercentage: 48.3,  giveaways: 16,  takeaways: 6,  season: 20122013,
      type: "P",  date_time: "2013-05-19",  venue_time_zone_tz: "EDT",  teamname: "Bruins"}]

    assert_equal expected_data, @stat_parser.merged_data
  end

end
