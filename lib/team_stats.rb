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

end
