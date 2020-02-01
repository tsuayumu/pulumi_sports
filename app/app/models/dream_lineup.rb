class DreamLineup < ActiveRecord::Base
	belongs_to :dream_lineup_manage
	belongs_to :dream_player
end
