class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  	if current_user.username = "Brennan"
  		@user = User.find(params[:id])
  	else
	    @user = current_user
		end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to(root_url, :notice => 'User was successfully created.') 
    else
      render :action => "new"
    end
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to(root_url, :notice => 'User was successfully updated.') 
    else
      render :action => "edit"
    end
  end
  
  def destroy
  	@user = User.find(params[:id])
		@user.destroy

		redirect_to(users_path)
  end
end
