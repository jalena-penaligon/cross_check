module LeagueStats

  def count_of_teams
    all_teams = []
    @data.each do |game_team|
      all_teams << game_team[:team_id]
    end
    all_teams.uniq.count
  end
  
end
