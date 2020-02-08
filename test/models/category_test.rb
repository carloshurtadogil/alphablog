require 'test_helper'

# Test the category model
class CategoryTest < ActiveSupport::TestCase
  # Method that will run first before everything else
  # Helps set up test variables
  def setup
    @category = Category.new(name: 'sports')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ' '
    # expecting a false return
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    @category2 = Category.new(name: 'sports')
    assert_not @category2.valid?
  end

  test 'name should not be too long' do
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end
end