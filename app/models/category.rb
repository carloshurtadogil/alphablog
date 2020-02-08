class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  # function for default page
  def index 
    
  end

  # function for the creation of a new category
  def new

  end

  # function for the display of a category
  def show

  end
end