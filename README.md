# Cross-Check

## To-Do

- Create schedule for due-dates

- **_All aggregations done_**

- Tests for `iteration 4` - Comments from WP
- Tests for `iteration 5` - skeleton complete

- Modules for `iteration 4`
- Modules for `iteration 5`

- WP -- Adding more to each `Data Row`
  - Opponent name
  - Opponent goals
  - ?Margin?
  - ?More?
  - ?home_goals and away_goals become unneeded?

**Data Row**
- All symbols
- converted to int/float/bool when appropriate

{game_id, team_id, hoa, won, settled_in, head_coach,
 goals, shots, hits, pim, powerplaygoals, powerplayopportunities, faceoffwinpercentage, giveaways, takeaways, teamname, season, type, date_time, venue_time_zone_tz, home_goals, away_goals}

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
