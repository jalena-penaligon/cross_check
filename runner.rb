require './lib/stat_tracker'

game_path = './data/game_very_small.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats_very_small.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
