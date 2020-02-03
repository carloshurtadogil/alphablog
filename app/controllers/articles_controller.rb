class ArticlesController < ApplicationController

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
    @article = Article.find(params[:id])
  end

  # Updates the article if any new changes are made
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to article_path(@article) # show udpated article
    else # default case to return to edit page 
      render 'edit'
    end
  end

  # Display the information found in the article
  def show
    @article = Article.find(params[:id])
  end

  private
    # Clean the article parameters
    def article_params
      params.require(:article).permit(:title, :description)
    end
end