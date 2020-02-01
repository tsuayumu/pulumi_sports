class League < ActiveRecord::Base
	has_many :teams

	enum status: { central: 1, pacific: 2 }

	scope :league, ->(league_name){ find_by(status: statuses[league_name.to_sym])}

	class << self
		def league_id(league_name)
			league(league_name).id
		end

		def central_teams
			find_by(status: statuses[:central]).try!(:teams)
		end

		def pacific_teams
			find_by(status: statuses[:pacific]).try!(:teams)
		end

		def league_regexp_for_routing
			Regexp.union(pluck(:name_en))
		end
	end

end
