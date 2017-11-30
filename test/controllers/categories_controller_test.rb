require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  #These tests are for the UI.  Remember, UI paths are routed via controller... so we do controller tests
  #We want to ensure that we have all the routes, 
  #and that those routes are accessible for the different actions we want to have


  def setup
    @category = Category.create(name: "sports")   #we want it to be created & hit the DB
    @user = User.create( username:"DaveAdmin", email:"d@d.com", password: "password", admin: true ) #simulate a logged in user
  end

  test "should get categories index" do 
    get :index #get is the HTTP verb.  This will look for a categories/index route, with an index action.
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id]= @user.id
    get :new
    assert_response :success 
  end
  
  test "should get show" do
     get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  
  test "should redirect create when no admin logged in" do
    #when a category create attempt is made without admin logged in, should not create a catgory, and should redirect to index.
    assert_no_difference 'Category.count' do
      post :create, category: {name: "Sports"}   #post this category to the create action
    end
    assert_redirected_to categories_path
  end
  

end