class TopController < ApplicationController
	def index
		@central_teams = League.central_teams
		@pacific_teams = League.pacific_teams
	end
end
