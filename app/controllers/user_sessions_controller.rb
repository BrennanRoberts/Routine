class UserSessionsController < ApplicationController
	
	skip_before_filter :require_login, :only => [:new, :create]
	
	def new
		@user_session = UserSession.new
	end	
	
	def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save 
			redirect_to workouts_path
		else
			render :action => "new"
		end
	end
	
	def destroy
		@user_session = UserSession.find(params[:id])
		@user_session.destroy
		redirect_to root_url
	end
end
