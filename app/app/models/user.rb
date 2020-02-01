class User < ActiveRecord::Base
	has_many :opening_starting_lineup

	class << self

	end

	def starting_lienups(args={})
		opening_starting_lineup.year(args[:year])
	end

	def password=(raw_password)
		if raw_password.kind_of?(String)
			self.hashed_password = BCrypt::Password.create(raw_password)
		elsif raw_password.nil?
			self.hashed_password = nil
		end
	end
end
