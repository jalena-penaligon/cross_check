require './test/test_helper'
require './lib/stat_tracker.rb'

class StatTrackerTest < MiniTest::Test
  def test_it_exists
    stat_tracker = StatTracker.new([{a: 1}, {b: 2}, {c: 3}], [:a, :b])
    assert_instance_of StatTracker, stat_tracker
  end

  def test_from_csv_works
    game_path = './data/game_very_small.csv'
    team_path = './data/team_info_very_small.csv'
    game_teams_path = './data/game_teams_stats_very_small.csv'
    test_csvs ={
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(test_csvs)

    game_array = [
      {game_id: '2012030221', season: '20122013', type: 'P', date_time: '2013-05-16',
        away_team_id: '3', home_team_id: '6', away_goals: '2', home_goals: '3',
        outcome: 'home win OT', home_rink_side_start: 'left', venue: 'TD Garden',
        venue_time_zone_id: 'America/New_York', venue_time_zone_offset: '-4',
        venue_time_zone_tz: 'EDT'},
      {game_id: '2012030222', season: '20122013', type: 'P', date_time: '2013-05-19',
        away_team_id: '3', home_team_id: '6', away_goals: '2', home_goals: '5',
        outcome: 'home win REG', home_rink_side_start: 'left', venue: 'TD Garden',
        venue_time_zone_id: 'America/New_York', venue_time_zone_offset: '-4',
        venue_time_zone_tz: 'EDT'}
    ]

    team_info_array = [
      {team_id: '1', franchiseid:'23', shortname: 'New Jersey',
      teamname: 'Devils', abbreviation: 'NJD'},
      {team_id: '4', franchiseid:'16', shortname: 'Philadelphia',
      teamname: 'Flyers', abbreviation: 'PHI'}
    ]

    game_team_array = [
      {game_id: '2012030221', team_id: '3', hoa: 'away', won: 'False', settled_in: 'OT',
        head_coach: 'John Tortorella', goals: '2', shots: '35', hits: '44', pim: '8',
        powerplayopportunities: '3', powerplaygoals: '0', faceoffwinpercentage: '44.8',
        giveaways: '17', takeaways: '7'},
      {game_id: '2012030221', team_id: '6', hoa: 'home', won: 'true', settled_in: 'OT',
        head_coach: 'Claude Julien', goals: '3', shots: '48', hits: '51', pim: '6',
        powerplayopportunities: '4', powerplaygoals: '1', faceoffwinpercentage: '55.2',
        giveaways: '4', takeaways: '5'},
      {game_id: '2012030222', team_id: '3', hoa: 'away', won: 'false', settled_in: 'REG',
        head_coach: 'John Tortorella', goals: '2', shots: '37', hits: '33', pim: '11',
        powerplayopportunities: '5', powerplaygoals: '0', faceoffwinpercentage: '51.7',
        giveaways: '1', takeaways: '4'},
      {game_id: '2012030222', team_id: '6', hoa: 'home', won: 'True', settled_in: 'REG',
        head_coach: 'Claude Julien', goals: '5', shots: '32', hits: '36', pim: '19',
        powerplayopportunities: '1', powerplaygoals: '0', faceoffwinpercentage: '48.3',
        giveaways: '16', takeaways: '6'}
    ]
    assert_equal Array, stat_tracker.data
    assert_equal 3, stat_tracker.data.count
    assert_equal '2012030221', stat_tracker.data[0][:game_id]
  end
end
