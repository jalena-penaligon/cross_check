# Cross-Check

## To-Do
### Responsibilities:

- Create schedule for due-dates
- Create new test file for StatTracker -- to be PR'd
- PR for StatParser (and push)

- SH - methods for `iteration 2`
- WP - test for `iteration3`
- JP - methods for `iteration 3`

- Starting to build iterations


**Data Row**
- All symbols
- converted to int/float/bool when appropriate

{game_id, team_id, hoa, won, settled_in, head_coach,
 goals, shots, hits, pim, powerplaygoals, powerplayopportunities, faceoffwinpercentage, giveaways, takeaways, teamname, season, type, date_time, venue_time_zone_tz, home_goals, away_goals}


class StatParser
  include GameStatistics
  include LeagueStatistics
  include TeamStatistics
  include SeasonStatistics

end

class StatTracker < StatParser

end

`Iteration 2`:
module GameStatistics

end

`Iteration 3`:
module LeagueStatistics

end

`Iteration 4`:
module TeamStatistics

end

`Iteration 5`:
module SeasonStatistics

end



#### Scratch

- Module division

- team name from team info most important

stat tracker open file-- leave as string

class as game and game/team info

- Class collects the list of hashes -- methods then do any appropriate
pre processing

StatTracker.from_csv(<hash of file_paths>)

s_t = StatTracker.new(data[:game],data[:game_teams], ..)

stat tracker Creates array of hashes (un processed) and passes to game, game_team and team_info


def initialize(game_path...)
  @game = Game.new(self.open_csv(game_path))
  @game_teams

[all_games_method] [all_game_team_methods]

if method is in one of those list
stat_tracker.highest_total_score -> stat_tracker.sum(goals) -> @game.highest_total_score -> here
