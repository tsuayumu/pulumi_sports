class Team < ActiveRecord::Base
	has_many :opening_starting_lineup
	belongs_to :league
	has_many :player

	scope :team_id, ->(name_en){ find_by(name_en: name_en).id}
	scope :team, ->(name_en){ find_by(name_en: name_en) }

	class << self
		def all_teams
			all
		end

		def all_teams_name
			pluck(:name_en)
		end

		def name_regexp_for_routing
			Regexp.union(self.all_teams_name)
		end
	end
end
