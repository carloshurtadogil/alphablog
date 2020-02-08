require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  # Set up test variables
  def setup
    @category = Category.create(name: 'sports')
    @category2= Category.create(name: 'programming')
  end

  test 'should show categories listing' do
    get categories_path
    assert_template 'categories/index' # Ensure the user is on the index page
    # Search for specific elements in the HTML page for confirmation
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end