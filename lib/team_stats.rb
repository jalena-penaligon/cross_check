module TeamStats

  def team_info(team_id)
    team_info = {}
    @data.each do |game_team|
      info = {
        team_id: game_team[:team_id],
        franchise_id: game_team[:franchiseid],
        short_name: game_team[:shortname],
        team_name: game_team[:teamname],
        abbreviation: game_team[:abbreviation],
        link: game_team[:link]
      }
      team_info[game_team[:team_id]] = info
    end
    team_info[team_id]
  end

  def wins_per_season(team_id)
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:team_id] == team_id && game_team[:won] == true
        games[game_team[:season]] += 1
      end
    end
    games
  end

  def win_percentage_by_season
    wins = count_away_wins
    num_games = count_away_games

    percentage = Hash.new(0)
    wins.each do |team, wins|
      percentage[team] = (wins /= num_games[team].to_f).round(3)
    end
    percentage
  end

  def best_season(team_id)
  end

end
