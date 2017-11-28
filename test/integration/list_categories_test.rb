require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup   #tests will start with these two categories created
    @category1 = Category.create(name: "sports")
    @category2 = Category.create(name: "programming")
  end


  test "should show categories listing" do
    get categories_path  #navigate to categories_path
    assert_template 'categories/index'  #checks the template exists
    
    assert_select "a[href=?]", category_path(@category1), text: @category1.name #select the link  with path to sports category view, check it's title is sports
    assert_select "a[href=?]", category_path(@category2), text: @category2.name #select the link with path to programming category view, check it's title is programming
  end
   
    
end