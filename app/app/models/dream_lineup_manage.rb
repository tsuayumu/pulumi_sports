class DreamLineupManage < ActiveRecord::Base
	has_many :dream_lineup
	accepts_nested_attributes_for :dream_lineup

end
