require './test/test_helper'
require './lib/stat_tracker_test.rb'

class StatTrackerTest < MiniTest::Test
  def test_it_exists
    stat_tracker = StatTracker.new
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
      {game_id: 2012030221, season: 20122013, type: 'P', date_time: '2013-05-16',
        away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3,
        outcome: 'home win OT', home_rink_side_start: 'left', venue: 'TD Garden',
        venue_time_zone_id: 'America/New_York', venue_time_zone_offset: -4,
        venue_time_zone_tz: 'EDT'},
      {game_id: 2012030222, season: 20122013, type: 'P', date_time: '2013-05-19',
        away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 5,
        outcome: 'home win REG', home_rink_side_start: 'left', venue: 'TD Garden',
        venue_time_zone_id: 'America/New_York', venue_time_zone_offset: -4,
        venue_time_zone_tz: 'EDT'}
    ]


    team_info_array = [
      {team_id: 1, franchiseId:23, shortName: "New Jersey",
      teamName: "Devils", abbreviation: "NJD"},
      {team_id: 4, franchiseId:16, shortName: "Philadelphia",
      teamName: "Flyers", abbreviation: "PHI"}
    ]

    game_team_array = [
      {game_id: 2012030221, team_id: 3, HoA: away, won: false, settled_in: OT,
        head_coach: 'John Tortorella', goals: 2, shots: 35, hits: 44, pim: 8,
        powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8,
        giveaways: 17, takeaways: 7},
      {game_id: 2012030221, team_id: 6, HoA: home, won: true, settled_in: OT,
        head_coach: 'Claude Julien', goals: 3, shots: 48, hits: 51, pim: 6,
        powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2,
        giveaways: 4, takeaways: 5},
      {game_id: 2012030222, team_id: 3, HoA: away, won: false, settled_in: REG,
        head_coach: 'John Tortorella', goals: 2, shots: 37, hits: 33, pim: 11,
        powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7,
        giveaways: 1, takeaways: 4},
      {game_id: 2012030222, team_id: 6, HoA: home, won: true, settled_in: REG,
        head_coach: 'Claude Julien', goals: 5, shots: 32, hits: 36, pim: 19,
        powerPlayOpportunities: 1, powerPlayGoals: 0, faceOffWinPercentage: 48.3,
        giveaways: 16, takeaways: 6}
    ]
  end
end
