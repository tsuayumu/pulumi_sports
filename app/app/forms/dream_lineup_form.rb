class DreamLineupForm
	include ActiveModel::Model

	validate :check_sum_average

	attr_accessor :dream_lineups

	def save
		return false unless valid_sum?
		lineup_manage = DreamLineupManage.create
		dream_lineups.each do |player|
			dream_player = DreamPlayer.create(
				average: 	player[1][:average].to_f / 1000,
				homerun: 	player[1][:homerun].to_i,
				rbi: 			player[1][:rbi].to_i,
				steal: 		player[1][:steal].to_i
			)
			DreamLineup.create(
				dream_lineup_manage_id: lineup_manage.id,
				dream_player_id: 				dream_player.id,
				order: 									player[1][:order]
			)
		end
	end

	private

	def valid_sum?
		sum = {
			average: 	0,
			homerun: 	0,
			rbi: 			0,
			steal: 		0
		}
		dream_lineups.each do |player|
			sum[:average] += player[1][:average].to_f
			sum[:homerun] += player[1][:homerun].to_i
			sum[:rbi] 		+= player[1][:rbi].to_i
			sum[:steal] 	+= player[1][:steal].to_i
		end

		valid_sum_average?(sum[:average]) & valid_sum_homerun?(sum[:homerun]) & valid_sum_rbi?(sum[:rbi]) & valid_sum_steal?(sum[:steal])
	end

	def valid_sum_average?(sum_average)
		sum_average <= 2250	
	end

	def valid_sum_homerun?(sum_homerun)
		sum_homerun <= 150
	end

	def valid_sum_rbi?(sum_rbi)
		sum_rbi <= 350
	end

	def valid_sum_steal?(sum_steal)
		sum_steal <= 80
	end
end
