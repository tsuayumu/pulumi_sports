class RankingController < ApplicationController

	def index
		@league = League.league(params[:league])
		@rankings = RankingManage.rankings(params[:league], params[:year])
		@ranking_form = RankingForm.new
		@select_teams = teams_for_select_form(@league)
		@year = params[:year]
	end

	def create
		@form = RankingForm.new(params[:ranking_form])
		@form.save
		redirect_to :index_ranking
	end

	def create_comment

	end

	private

	def teams_for_select_form(league)
		team_and_id = []
		league.teams.each do |team|
			team_and_id << [team.name, team.id]
		end
		team_and_id
	end
end
