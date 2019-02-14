module Conversions

  def convert_to_boolean(hash)
    to_boolean = [:won]

    to_boolean.each do |key|
      if hash[key].upcase == "FALSE"
        hash[key] = false
      else
        hash[key] = true
      end
    end

    return hash
  end

  def convert_to_float(hash)
    to_float = [:faceoffwinpercentage]

    to_float.each do |key|
      if hash.keys.include?(key)
        hash[key] = hash[key].to_f
      end
    end

    return hash
  end

  def convert_to_int(hash)
    to_int = [:game_id, :season, :away_goals,:home_goals, :team_id, :goals,
              :shots, :hits, :pim, :powerplayopportunities, :powerplaygoals,
              :giveaways, :takeaways]

    to_int.each do |key|
      if hash.keys.include?(key)
        hash[key] = hash[key].to_i
      end
    end

    return hash
  end

  def delete_keys(hash)
    to_delete = [nil, :venue_time_zone_id, :venue_time_zone_offset,
                :home_rink_side_start, :franchiseid, :venue_link, :venue,
                :abbreviation, :link, :shortname, :away_team_id, :home_team_id,
                :outcome]

    to_delete.each do |key|
      hash.delete(key)
    end

    return hash
  end
end
