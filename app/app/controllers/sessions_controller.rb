class SessionsController < ApplicationController
	def new
		if current_user
			redirect_to :user_mypage_index
		else
			@form = LoginForm.new
			render action: 'new'
		end
	end

	def create
		@form = LoginForm.new(params[:login_form])
		if @form.email.present?
			user = User.find_by(email: @form.email)
		end
		if Authenticator.new(user).authenticate(@form.password)
			session[:user_id] = user.id
			redirect_to :user_mypage_index
		else
			render action: 'new'
		end			
	end

	def destroy
		session.delete(:user_id)
		redirect_to :root
	end
end
