require 'csv'
require 'pry'

class StatTracker

  attr_accessor :data,
                :merge_ids

  def initialize
    @data = []
    @merge_ids = [:game_id, :team_id]
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new

    game_teams = stat_tracker.open_csv(locations[:game_teams])
    game = stat_tracker.open_csv(locations[:games])
    team_info = stat_tracker.open_csv(locations[:teams])

    raw_data = [game_teams, game, team_info]
    stat_parser = StatParser.new(raw_data, stat_tracker.merge_ids)
    stat_tracker.data = stat_parser.merge_data

    return stat_tracker
  end

  def open_csv(file_path)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    contents_hash = contents.map do |row|
      row.to_hash
    end
  end
end
