module Conversions

  def convert_won_to_boolean(hash)
      if hash[:won].upcase == "FALSE"
        hash[:won] = false
      else
        hash[:won] = true
      end
    return hash
  end

  def delete_keys(hash)
    to_delete = [nil, :venue_time_zone_id, :venue_time_zone_offset,
                :home_rink_side_start, :venue, :link, :away_team_id,
                :home_team_id, :outcome, :home_goals, :away_goals]

    to_delete.each do |key|
      hash.delete(key)
    end

    return hash
  end
end
