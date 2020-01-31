class ArticlesController < ApplicationController

  # Creates a new article instance
  def new
    @article = Article.new
  end

  # Submits the new article information
  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_show(@article)
  end

  private
    # Clean the article parameters
    def article_params
      params.require(:article).permit(:title, :description)
    end
end