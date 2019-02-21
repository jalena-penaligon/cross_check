# Cross-Check

## Step 1:
**Merge Data**

Take the info from the `game_team`, `game` and `team_info` data, and merge all into the `game_team` data. Thus, each game has two hashes; one for home and one for away team.

**Contents of each Hash**
- All symbols for keys
- converted to int/float/bool when appropriate
- `opponent` and `opponent_goals` added
- `franchiseid`, `shortname`, and `abbreviation` undeleted.
- `goals` and `opponent_goals` are from game data
- `gt_goals` are from game_team data

{game_id, team_id, hoa, won, settled_in, head_coach,
 goals, shots, hits, pim, powerplaygoals, powerplayopportunities, faceoffwinpercentage, giveaways, takeaways, teamname, season, type, date_time, venue_time_zone_tz, opponent, opponent_goals, franchiseid, shortname, abbreviation, opponent_id, gt_goals}

## Step 2:
**Subset Data**

When necessary pick out only the games that match a certain criteria. E.g.: only games from a certain season; or only games played by one team.

## Step 3:
**Group Data**

Pick a `key` from the game hash (described above). The remaining games will be split among the unique values of that `key`. Yeilding a hash with the keys of the unique values of the `key` from the game hash, and the values of the list of games that contain that key:value pair.

E.g. Grouping by `:season`, will yeild:  
{20122013 => [<all games from 2012/13 season>],  
20132014 => [<all games from 2013/14 season>], ...}

## Step 4:
**Aggregate Data**

Specify a method which will ingest a list of games and return a statistic; e.g. winning percentage.
This yields a hash similar to above, EXCEPT the values have been replaced with that statistic

## (optional) Step 5:
**Find Min/Max**

Find the min/max value from the above hash.   

**Class Structure**
```
class StatParser
  include Conversions
end
```

```
class StatTracker
  include GameStatistics
  include LeagueStatistics
  include TeamStatistics
  include SeasonStatistics
  include helpers
  include aggregators
end
```

**Iteration 2:**
```
module GameStatistics

end
```

**Iteration 3:**
```
module LeagueStatistics

end
```
**Iteration 4:**
```
module TeamStatistics

end
```

**Iteration 5:**
```
module SeasonStatistics

end
```
