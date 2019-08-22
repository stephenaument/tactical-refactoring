require 'ostruct'
require_relative './team_stat'

class Tournament
  HEADER = "Team                           | MP |  W |  D |  L |  P\n"

  attr_reader :games

  def initialize(games)
    @games = games
  end

  class << self
    def tally(games)
      new(games).tally
    end
  end

  def tally
    "#{HEADER}#{team_stats.sort.join}"
  end

  def team_stats
    team_stats = {}

    games.each_line do |game|
      next if game.chomp!.empty?

      first_team, second_team, outcome = game.split(';')

      team_stats[first_team] ||= TeamStat.new(name: first_team)
      team_stats[second_team] ||= TeamStat.new(name: second_team)
      team_stats[first_team].matches_played += 1
      team_stats[second_team].matches_played += 1

      if outcome == 'win'
        team_stats[first_team].wins += 1
        team_stats[first_team].points += 3
        team_stats[second_team].losses += 1
      elsif outcome == 'loss'
        team_stats[second_team].wins += 1
        team_stats[second_team].points += 3
        team_stats[first_team].losses += 1
      else
        team_stats[first_team].draws += 1
        team_stats[first_team].points += 1
        team_stats[second_team].draws += 1
        team_stats[second_team].points += 1
      end
    end

    team_stats.values
  end
end
