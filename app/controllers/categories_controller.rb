class CategoriesController < ApplicationController
  # function that carries out operations for the index page
  def index
    @categories = Category.all
  end

  # function that carries out operations for the 'New Category' page
  def new
    @category = Category.new
  end

  # function that carries out operations for creating a new category
  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = 'Category was created successfully'
      redirect_to categories_path
    else 
      render 'new'
    end
  end

  # function that carries out operations for displaying a category
  def show

  end

  private 
  def category_params
    params.require(:category).permit(:name)
  end
end