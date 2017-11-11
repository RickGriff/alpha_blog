class UsersController < ApplicationController
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5 )
  end
  
  def new
    @user= User.new
  end

  def create
    @user = User.new(user_params) 
    
    if @user.save #if it passes validations and hits the DB
      flash[:success] =  "Welcome to the Alpha Blog #{:username}!"
      redirect_to articles_path
    else
      render 'new'  #if doesnt save, it re-loads the new page.  New page will render any errors that occurred, because that's coded into the New page.
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit' # reload the page and display the errors
    end
  end

  def show 
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate( page: params[:page], per_page: 5 )
  end
  
  private
  def user_params   # We need to call a permit method to get user's params.  Params seem to be stored in some general hash, with a user key, then need to permit it's values.
    params.require(:user).permit(:username, :email, :password)
  end
  
  
  
end