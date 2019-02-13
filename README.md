# Cross-Check

## To-Do
### Responsibilities:

- Create schedule for due-dates

- Starting to build iterations

- SH - methods for `iteration 2` -- 3 methods left
- WP - tests for `iteration3` -- Almost done (need to check 2) -- slack to JP
- JP - methods for `iteration 3` -- 1/2 wayish

- aggs for `it 4` -- WP next
- aggs for `it 5` -- WP next

- Tests for `iteration 4` -- SH next
- Tests for `iteration 5`

- Modules for `iteration 4` -- JP next
- Modules for `iteration 5`

## Iteration 5 by ?Friday?



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
