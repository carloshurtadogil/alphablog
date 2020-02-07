class UsersController < ApplicationController

  # require a user for certain functions
  before_action :set_user, only: [:edit, :update, :show]

  # Ensure a user is the owner of the account to make edits, updates, and destructions
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # Give admins the ability to destroy articles
  before_action :require_admin, only: [:destroy]

  # function for new users
  def new
    @user = User.new
  end

  # function for creating new users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to AlphaBlog, #{@user.username}"
      redirect_to articles_path
    else
      # reload the page (will show the error messages)
      render 'new'
    end
  end

  # function for users to edit their information
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      #reloard the page
      render 'edit'
    end
  end

  # function for certain users to destroy certain profiles, depending on rights
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all associated articles have been deleted"
    redirect_to users_path
  end


  # function to show user profile
  def show
    @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  # function to display all users
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Ensures the user has proper access to their own content
  def require_same_user
    if !logged_in? and current_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  # Allows admin rights
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admins can perform this action"
      redirect_to root_path
    end
  end
end