require 'test_helper'  # needed for all test models

class CategoryTest < ActiveSupport::TestCase    
  
  def setup  #setup method runs before every test below.  Every test below follows this assignment.

    @category = Category.new(name: "sports") 
  end
    
    
  test "category should be valid" do   #Test whether we can create a new Category object.
    assert @category.valid?       #assert returns true if @category is a valid object. -- if there's no category model,
    #it will fail. Because @category = Category.new... , as defined above.
  end
  
  
  test "name should be present" do  #test whether a Category object must have a name.  Fail if it can get away with not having a name.
    @category.name = ' '   #sets the newly created Category name to empty.
    assert_not @category.valid?  #assert_not returns true if @category is NOT valid object.  Returns true if @category does NOT validations.
  end  #So if this test returns false ---> Need to create validations such that @category.name can not be empty.
 
  test "name should be unique" do
    @category.save  #save the Category object created by Setup
    category2 = Category.new(name: "sports")  #new category object with same name as the one just saved
    assert_not category2.valid?  #assertion returns true if category2 does not pass validations.
  end
    

  test "name should not be >25 chars long" do
    @category.name = 'a'*26  
    assert_not @category.valid?  #assertion returns true if @category does not pass validation
  end
  
  test "name should not be too short, <3" do
    @category.name = 'a'*2
    assert_not @category.valid?
    
  end
    
    
    
    
end