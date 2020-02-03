class ArticlesController < ApplicationController
  # Initialize the article variable with a given parameter for specified methods only
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  def index
    @articles = Article.all
  end

  # Creates a new article instance
  def new
    @article = Article.new
  end

  # Submits the new article information
  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "Article was successfully created!"
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
      flash[:notice] = "Article was updated successfully"
      redirect_to article_path(@article) # show udpated article
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
    flash[:notice] = "Article was deleted successfully" # Notify
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
end