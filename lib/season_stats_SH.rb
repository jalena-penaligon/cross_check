module SeasonStatsSH

  def most_accurate_team(season_id)
    subsets = {season: season_id.to_i}
    group_id = :teamname
    aggregate = :shooting_percentage
    find_max(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def least_accurate_team(season_id)
    subsets = {season: season_id.to_i}
    group_id = :teamname
    aggregate = :shooting_percentage
    find_min(subset_group_and_aggregate(subsets, group_id, aggregate))
  end

  def total_goals(data = nil)
    if data == nil
      data = @data
    end
    hashID = :goals
    find_total(hashID, data)
  end

  def total_shots(data = nil)
    if data == nil
      data = @data
    end
    hashID = :shots
    find_total(hashID, data)
  end

  def shooting_percentage(data = nil)
    if data == nil
      data = @data
    end
    total_goals(data)/total_shots(data).to_f
  end
end

# {season1 => {teamname1 => ratio,
#             teamname2 => ratio}}
