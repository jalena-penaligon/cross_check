require 'csv'
require 'pry'
require_relative './league_stats'
require_relative './stat_parser'
require_relative './game_stats'
require_relative './season_stats'
require_relative './team_stats'
require_relative './helpers'
require_relative './aggregators'


class StatTracker
  include LeagueStats
  include SeasonStats
  include Helpers
  include GameStats
  include TeamStats
  include Aggregators

  attr_accessor :data,
                :merge_ids

  def initialize
    @data = []
    @merge_ids = [:game_id, :team_id]
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new

    raw_data = stat_tracker.open_all_csvs(locations)

    stat_parser = StatParser.new(raw_data, stat_tracker.merge_ids)
    stat_tracker.data = stat_parser.parse_data

    return stat_tracker
  end

  def open_all_csvs(locations)
    return [open_csv(locations[:game_teams]),
            open_csv(locations[:games]),
            open_csv(locations[:teams])]
  end

  def open_csv(file_path)
    contents = CSV.open(file_path, headers: true,
                        header_converters: :symbol,
                        converters: :numeric)
    contents_hash = contents.map do |row|
      row.to_hash
    end
  end
end
