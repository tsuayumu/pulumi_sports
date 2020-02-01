class OpeningStartingLineupController < ApplicationController
	before_action :permit_all_parameters, only: [:create, :create_comment]

	def index
		@team = Team.team(params[:team])
		@year = params[:year]
		@lineup_form = OpeningStartingLineupForm.new(default_lineup)
		@opening_lineups = LineupManage.team_lienups(params[:team], params[:year]).reverse
		@comment_form = OpeningStartingLineupCommentForm.new
		@select_players = Player.team_player(@team.id, @year)
	end

	def create
		@form = OpeningStartingLineupForm.new(params[:opening_starting_lineup_form])
		@form.save
		redirect_to :index_opening_starting_lineup
	end

	def create_comment
		@form = OpeningStartingLineupCommentForm.new(params[:opening_starting_lineup_comment_form])
		@form.save
		redirect_to :index_opening_starting_lineup
	end

	private
	def default_lineup
		OpeningStartingLineup::DefaultLineups.new(params[:team], @year).lineup
	end

	def permit_all_parameters
		# strong_parameterが解決できないため暫定対応
		ActionController::Parameters.permit_all_parameters = true
	end
end
