class SessionsController < ApplicationController
  
  # for the page itself
  def new

  end

  # function to be carried out when logging in
  def create
    user = User.find_by(email: params[:session][:email].downcase) # find the user instance with their email as a parameter

    # if user exists and their password is correct
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in'
      # redirect user to their profile page
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Invalid Credentials'
      render 'new'
    end
  end

  # function to remove user from profile and end their session
  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have successfully logged out'
    redirect_to root_path
  end
end