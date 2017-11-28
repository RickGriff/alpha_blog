require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  #These tests are for the UI.  Remember, UI paths are routed via controller... so we do controller tests
  #We want to ensure that we have all the routes, 
  #and that those routes are accessible for the different actions we want to have


  def setup
    @category = Category.create(name: "sports")   #we want it to be created & hit the DB
  end

  test "should get categories index" do 
    get :index #get is the HTTP verb.  This will look for a categories/index route, with an index action.
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success 
  end
  
  test "should get show" do
     get(:show, {'id' => @category.id})
    assert_response :success
  end
  
end