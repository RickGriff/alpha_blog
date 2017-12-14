class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy] #for these actions, set_article executes and makes @article = Article.find(params[:id]). 
  before_action :require_user, except: [:index, :show]  #all new, edit, create, update, delete actions require a logged in user -- require_user in ApplicationController is called
  before_action :require_same_user, only: [:edit, :update, :destroy] #to actually edit, update or destroy an article requires the current user actually own the article
  
  def index
  @articles = Article.paginate( page: params[:page], per_page: 5 )
  end
  
  def new #so, When you load .../articles/new, you are actually also instantiating a new @article variable.
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def create
    
    @article = Article.new(article_params)
    @article.user = current_user  #This should create all new articles belonging to the current logged in user.
    if @article.save  # this *actually saves* the article to the DB. It's not an equivalence check with ==.  It attempts to save article, and if the transaction goes through, flash is set and browser redirects
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
     flash[:success] = "Article was successfully updated"
     redirect_to article_path(@article)
    else
    render 'edit'  #render the edit template again if the update hasn’t worked
    end
  end

  def show
  @article = Article.find(params[:id])  #params is a hash of the entry’s fields.  ID, title, #desc, etc.
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private
  
  def set_article
     @article = Article.find(params[:id])
  end
    
  def require_same_user
    if current_user != @article.user && !current_user.admin?  #block the action if current_user does not own the article and is also not Admin.
      flash[:danger] = "Sorry, you can only edit your own articles"
      redirect_to root_path
    end
  end
    
  def article_params
    params.require(:article).permit(:title, :description, category_ids: []) # allows the created article to take params entered from form(?)
  end
  
  
  
end