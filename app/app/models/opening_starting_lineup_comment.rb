class OpeningStartingLineupComment < ActiveRecord::Base
	scope :comments, ->(opening_starting_lineup_id){ where(opening_starting_lineup_id: opening_starting_lineup_id)}
end
