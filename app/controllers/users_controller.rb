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

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end