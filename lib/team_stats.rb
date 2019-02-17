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

  def games_per_season(team_id)
    games = Hash.new(0)
    @data.each do |game_team|
      if game_team[:team_id] == team_id
        games[game_team[:season]] += 1
      end
    end
    games
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

  def win_percentage_by_season(team_id)
    wins = wins_per_season(team_id)
    num_games = games_per_season(team_id)

    percentage = Hash.new(0)
    wins.each do |team, wins|
      percentage[team] = (wins /= num_games[team].to_f).round(3)
    end
    percentage
  end

  def best_season(team_id)
    win_percentage_by_season(team_id).max_by do |season, winning_percentage|
      winning_percentage
    end.first
  end

  def worst_season(team_id)
    win_percentage_by_season(team_id).min_by do |season, winning_percentage|
      winning_percentage
    end.first
  end

end
