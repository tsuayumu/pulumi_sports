class DreamBattleController < ApplicationController
	def index
		battle = DreamBattle.new(session[:my_dream_lineup_id], params[:dream_lineup_id])
		render :index, json: { status: 'success', score: battle.score }
	end

	def create
		session[:my_dream_lineup_id] = params[:dream_lineup_id]
		render :index, json: { status: 'success' }
	end
end
