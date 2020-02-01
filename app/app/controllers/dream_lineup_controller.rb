class DreamLineupController < ApplicationController
	def index
		@dream_lineups = DreamLineupManage.all
		@lineup_form = DreamLineupForm.new
	end

	def create
		@form = DreamLineupForm.new(params[:dream_lineup_form])
		if @form.save
			redirect_to :index_dream_lineup
		else
			redirect_to :index_dream_lineup
		end
	end
end
