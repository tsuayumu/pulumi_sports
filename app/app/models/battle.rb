class Battle

	def initialize(my_opening_lineup_id, enemy_opening_lineup_id)
		@my_opening_lineup = LineupManage.find(my_opening_lineup_id)
		@enemy_opening_lineup = LineupManage.find(enemy_opening_lineup_id)
		@my_offence = Offense.new(my_opening_lineup_id)
		@enemy_offence = Offense.new(enemy_opening_lineup_id)
		@my_offence.playball
		@enemy_offence.playball
	end

	def record
		if @my_offence.total_score > @enemy_offence.total_score
			@my_opening_lineup.win += 1
			@enemy_opening_lineup.lose += 1
		elsif @my_offence.total_score < @enemy_offence.total_score
			@my_opening_lineup.lose += 1
			@enemy_opening_lineup.win += 1
		else
			@my_opening_lineup.draw += 1
			@enemy_opening_lineup.draw += 1
		end
		@my_opening_lineup.save!
		@enemy_opening_lineup.save!
	end

	def score
		"あなた：#{@my_offence.total_score} 点  相手：#{@enemy_offence.total_score} 点"
	end

	def my_record
		{
			id: @my_opening_lineup.id,
			win: @my_opening_lineup.win,
			lose: @my_opening_lineup.lose,
			draw: @my_opening_lineup.draw
		}
	end

	def enemy_record
		{
			id: @enemy_opening_lineup.id,
			win: @enemy_opening_lineup.win,
			lose: @enemy_opening_lineup.lose,
			draw: @enemy_opening_lineup.draw
		}
	end
end
