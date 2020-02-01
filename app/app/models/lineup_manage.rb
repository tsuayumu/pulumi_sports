class LineupManage < ActiveRecord::Base
	belongs_to :team
	belongs_to :user
	has_many :lineup
	accepts_nested_attributes_for :lineup

	scope :team, ->(team){ where(team_id: team) }
	scope :year, ->(year){ where(year: year) }

	class << self
		def team_lienups(team, year)
			team_id = Team.team_id(team)
			team(team_id).year(year)
		end
	end

	def lineups
		lineup
	end
end
