require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  test "get new category form and create category" do
    get new_category_path   #attempt to get the new category path via HTTP request
    assert_template 'categories/new' #assert existence of the 'new category' view
   
    assert_difference 'Category.count', 1 do  #Tests whether 1 new category object has actually been created
      post_via_redirect categories_path, category: {name: "sports"} #post the category with name "sports" via form, and redirect
    end
    assert_template 'categories/index' #check the existence of the index
    assert_match "sports", response.body  #check whether the category 'Sports' is listed in the index page
  end
    
  test "Invalid category submission yields a failure" do
    get new_category_path   
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do  #check no category was created when we don't submit a valid name
      post_via_redirect categories_path, category: {name: " "} 
    end
    assert_template 'categories/new'
   # check whether we are getting the expected elements from the errors partial
    assert_select 'h2.card-title'
    assert_select 'div.for-test'
  end
   
end