class UsersController < ApplicationController

  # function for new users
  def new
    @user = User.new
  end

  # function for creating new users
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to AlphaBlog, #{@user.username}"
      redirect_to articles_path
    else
      # reload the page (will show the error messages)
      render 'new'
    end
  end

  # function for users to edit their information
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      #reloard the page
      render 'edit'
    end
  end

  # function to show user profile
  def show
    @user = User.find(params[:id])
  end

  # function to display all users\
  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end