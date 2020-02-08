require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test 'invalid category submission results in failure' do 
    get new_category_path #access the category path for new categories
    assert_template 'categories/new'# ensure the user will land on the 'New Category'

    # no categories should be made
    assert_no_difference 'Category.count' do 
      post categories_path, params: { category: {name: ' '} } # attempt post an invalid category
    end

    assert_template 'categories/new' # ensure the user will be remain on the same page

    # search for particular error messages, which will be found with the following tags and classes
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

  end

  # Tests the creation of a new category and the subsequent navigation between appropriate pages
  test 'get new category form and create category' do
    get new_category_path # access the category path for new categories
    assert_template 'categories/new' # ensure that it will show
    # there should be 1 category after posting to the path
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: 'sports'} } # post the 'sports' category
      follow_redirect! # ensure that the page redirects
    end
    assert_template 'categories/index' # ensure that the user will land on the index page
    assert_match 'sports', response.body # ensure that the 'sports' value can be found on the page through the reponse body
  end
end