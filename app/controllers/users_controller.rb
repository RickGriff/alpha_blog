class UsersController < ApplicationController
  
  
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5 )
  end
  
  def new
    @user= User.new
  end

  def create
    @user = User.new(user_params) 
    
    if @user.save # this *actually saves* the user to the DB. It's not an equivalence check with ==.  It attempts to save user, and if the transaction goes through, flash is set and browser redirects
      session[:user_id] = @user.id
      flash[:success] =  "Welcome to the Alpha Blog #{:username}!"
      redirect_to user_path(@user)
    else
      render 'new'  #if doesnt save, it re-loads the new page.  New page will render any errors that occurred, because that's coded into the New page.
    end
    
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit' # reload the page and display the errors
    end
  end

  def show 
    @user_articles = @user.articles.paginate( page: params[:page], per_page: 5 )
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "user and all articles created by user have been deleted"
    redirect_to users_path
  end
  
  
  def set_user
    @user = User.find(params[:id])
  end
  
  private
  def user_params   # We need to call a permit method to get user's params.  Params seem to be stored in some general hash, with a user key, then need to permit it's values.
    params.require(:user).permit(:username, :email, :password)
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?  #Deny the action if they're not an admin or they are not the user they're trying to edit/update/delete
      flash[:danger] = "Sorry, you can only edit your own account."
      redirect_to root_path
    end
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Sorry, only admins can delete users"
      redirect_to root_path
    end
  end
  
end