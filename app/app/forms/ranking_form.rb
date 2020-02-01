class RankingForm
	include ActiveModel::Model

	attr_accessor :league_id, :year, :rankings

	def save
		ranking_manage = RankingManage.new(league_id: league_id, year: year, ranking_attributes: rankings)
		ranking_manage.save!
	end
end
