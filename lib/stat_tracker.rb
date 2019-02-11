require 'csv'
require 'pry'

class StatTracker

  attr_accessor :game,
                :team_info,
                :game_teams

  def initialize
    @game = nil
    @team_info = nil
    @game_teams = nil
  end

  def self.from_csv(data)
    stat_tracker = StatTracker.new
    deleted_keys = [nil, :venue_link]
    integer_keys = [:game_id, :season, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue_time_zone_offset]
    stat_tracker.game = stat_tracker.open_csv(data[:games], integer_keys, deleted_keys: deleted_keys)
    integer_keys = [:game_id, :team_id, :goals, :shots, :hits, :pim, :powerplayopportunities, :powerplaygoals, :giveaways, :takeaways]
    boolean_keys = [:won]
    float_keys = [:faceoffwinpercentage]
    stat_tracker.game_teams = stat_tracker.open_csv(data[:game_teams], integer_keys, boolean_keys: boolean_keys, float_keys: float_keys)
    integer_keys = [:team_id, :franchiseid]
    deleted_keys = [nil, :link]
    stat_tracker.team_info = stat_tracker.open_csv(data[:teams], integer_keys, deleted_keys: deleted_keys)
    return stat_tracker

  end

  def open_csv(file_path, integer_keys, boolean_keys: [], float_keys: [], deleted_keys: [nil])
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)

    contents_hash = contents.map do |row|
      temp = row.to_hash
      deleted_keys.each do |key|
        temp.delete(key)
      end
      integer_keys.each do |key|
        temp[key] = temp[key].to_i
      end
      boolean_keys.each do |boolean|
        if temp[boolean] == "False"
          temp[boolean] = false
        else
          temp[boolean] = true
        end
      end
      float_keys.each do |float|
        temp[float] = temp[float].to_f
      end
      temp
      # binding.pry
    end
  end
end
