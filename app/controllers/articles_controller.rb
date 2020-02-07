class ArticlesController < ApplicationController
  # Initialize the article variable with a given parameter for specified methods only
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  # Require a user to be logged in for all pages except pages that are index or for show
  before_action :require_user, except: [:index, :show]

  # Only the article owner can use the edit, update, and destroy functions for the specific article
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
  end

  # Creates a new article instance
  def new
    @article = Article.new
  end

  # Submits the new article information
  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else # default case for when article experiences error during save
      render 'new'
    end

  end

  # Allows for the revision of an article
  def edit
    
  end

  # Updates the article if any new changes are made
  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully"
      redirect_to article_path(@article) # show updated article
    else # default case to return to edit page 
      render 'edit'
    end
  end

  # Display the information found in the article
  def show
    
  end

  # Function to delete articles from the database
  def destroy
    
    @article.destroy #Destroy
    #danger will give the alert a red background
    flash[:danger] = "Article was deleted successfully" # Notify
    redirect_to articles_path #Redirect
  end

  private
    # Clean the article parameters
    def article_params
      params.require(:article).permit(:title, :description)
    end

    # Retrieve an article
    def set_article
      @article = Article.find(params[:id])
    end

    # Ensure that the user functions for specific articles are available to a specific user
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "You do not own this article and thus cannot edit nor delete it"
        redirect_to root_path
      end
    end
end