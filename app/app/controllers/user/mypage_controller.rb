class User::MypageController < ApplicationController
	def index
		@user = current_user
		@starting_lineups = @user.starting_lienups({year: 2018})
	end
end
