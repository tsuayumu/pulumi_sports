class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash.notice = 'ユーザーアカウントを新規登録しました'
			redirect_to :user_mypage_index
		else
			render action: 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.assign_attributes(user_params)
		if @user.save
			flash.notice = "ユーザーアカウントを更新しました"
			redirect_to :user_mypage_index
		else
			render action: 'edit'
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
