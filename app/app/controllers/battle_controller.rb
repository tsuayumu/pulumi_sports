class BattleController < ApplicationController
	before_action :valid_battle?

	def index
		battle = Battle.new(session[:my_opening_lineup_id], params[:opening_lineup_id])
		battle.record
		render :index, json: result(battle)
	end

	def create
		session[:my_opening_lineup_id] = params[:opening_lineup_id]
		render :index, json: { status: 'success' }
	end

	private

	def valid_battle?
		render :index, json: { status: 'success', score: "同じチームでは試合できません" } if session[:my_opening_lineup_id] == params[:opening_lineup_id]
	end

	def result(battle)
		 { 
				status: 'success',
				score: battle.score,
				my_record: battle.my_record,
				enemy_record: battle.enemy_record
			}
	end
end
