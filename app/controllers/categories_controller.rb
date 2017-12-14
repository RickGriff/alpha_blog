class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]  #admin should be required for all C,U,D actions for categories
  
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
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  def category_params #whitelisting the name parameter, and making it available to the create action (?)
    params.require(:category).permit(:name)
  end
  
  def require_admin
    #check user if user is not logged in, or is logged in but not admin:
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "Sorry that action is only available to Admins"
      redirect_to categories_path
    end
  end
  

end