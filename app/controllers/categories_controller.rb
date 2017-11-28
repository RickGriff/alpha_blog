class CategoriesController < ApplicationController

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category =Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path #redirect to index
      
    else
      render 'new'
    end
  end
  
  def show
  end
  
  private
  def category_params #whitelisting the name parameter, and making it available to the create action (?)
    params.require(:category).permit(:name)
  end
  


end