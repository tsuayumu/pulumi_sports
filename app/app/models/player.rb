class Player < ActiveRecord::Base
	has_one :player_record
	has_many :lineup
	belongs_to :team

	class << self
		def team_player(team, year)
			name_and_id = []
			players = where(team_id: team, year: year)
			players.each do |player|
				name_and_id << [player.name, player.id]
			end
			name_and_id
		end
	end
end
