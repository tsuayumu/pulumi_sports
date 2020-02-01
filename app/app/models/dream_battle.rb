class DreamBattle

	def initialize(my_dream_lineup_id, enemy_dream_lineup_id)
		@my_offence = DreamOffense.new(my_dream_lineup_id)
		@enemy_offence = DreamOffense.new(enemy_dream_lineup_id)
		@my_offence.playball
		@enemy_offence.playball
	end

	def score
		"あなた：#{@my_offence.total_score} 点  相手：#{@enemy_offence.total_score} 点"
	end
end
