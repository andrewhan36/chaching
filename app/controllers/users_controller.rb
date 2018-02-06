class UsersController < ApplicationController
	def new
	end

	def create
	  @user = User.new(params[:user].permit(:name, :uuid))
	  @user.uuid = SecureRandom.uuid
	  @user.save
	  redirect_to @user
	end

	def show
		@user = User.find(params[:id])
	end

	def index
		@user_list = User.last(20)
	end
end
