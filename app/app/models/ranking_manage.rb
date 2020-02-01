class RankingManage < ActiveRecord::Base
	has_many :ranking
	accepts_nested_attributes_for :ranking

	class << self
		def rankings(league, year)
			league_id = League.league_id(league)
			where(league_id: league_id).where(year: year)
		end
	end
end
