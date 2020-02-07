class SessionsController < ApplicationController
  
  # for the page itself
  def new

  end

  # function to be carried out when logging in
  def create
    user = User.find_by(email: params[:session][:email].downcase)
  end

  # function to remove users
  def destroy

  end
end