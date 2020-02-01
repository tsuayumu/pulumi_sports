class Lineup < ActiveRecord::Base
	belongs_to :lineup_manage
	belongs_to :player

end
