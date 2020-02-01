class DreamOffense

	def initialize(dream_lineup_id)
		@field = {
			first: 		false,
			second: 	false,
			third: 		false
		}
		@out = 0
		@order = 1
		@point = 0
		@ining = 1
		@all_ining = [0,0,0,0,0,0,0,0,0]
		@lineup =  DreamLineupManage.find(dream_lineup_id).dream_lineup
	end

	def playball
		1..9.times do
			until @out == 3 do
				batter = @lineup.find_by(order: @order).dream_player
				if batter.try!(:average) && hit_probability((batter.average * 1000).to_i)
					if homerun_probability(batter.try!(:homerun))
						homerun
					else
						hit
					end
				else
					out
				end
				change_batter
			end
			change
		end
	end

	def total_score
		@all_ining.sum
	end

	private

	def hit
		case @field
		when {first: false, second: false, third: false} then
			@field = {first: true, second: false, third: false}
		when {first: true, second: false, third: false} then
			@field = {first: true, second: true, third: false}
		when {first: false, second: true, third: false} then
			@field = {first: true, second: false, third: false}
		when {first: true, second: true, third: false} then
			@field = {first: true, second: true, third: true}
		when {first: false, second: false, third: true} then
			@field = {first: true, second: false, third: false}
			get_point(1)
		when {first: true, second: false, third: true} then
			@field = {first: true, second: true, third: false}
			get_point(1)
		when {first: false, second: true, third: true} then
			@field = {first: true, second: false, third: true}
			get_point(1)
		when {first: true, second: true, third: true} then
			@field = {first: true, second: true, third: true}
			get_point(1)
		end
	end

	def homerun
		get_point(@field.select{|k, v| v == true}.size + 1)
		@field = {
			first: 		false,
			second: 	false,
			third: 		false
		}
	end

	def out
		@out += 1
	end

	def change_batter
		if @order == 9
			@order = 1
		else
			@order += 1
		end
	end

	def change
		@all_ining[@ining-1] = @point
		@ining += 1
		@out = 0
		@point = 0
		@field = {
			first: 		false,
			second: 	false,
			third: 		false
		}
	end

	def get_point(point)
		@point += point
	end

	def hit_probability(n)
		return false if n.nil?
		([true] * n + [false] * (1000 - n)).sample
	end

	def homerun_probability(n)
		return false if n.nil?
		([true] * n + [false] * (120 - n)).sample
	end
end
