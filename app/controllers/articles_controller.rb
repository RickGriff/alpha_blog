class ArticlesController < ApplicationController
  
  def index
  @all_articles = Article.all
  end
  def new #so, When you load .../articles/new, you are actually also instantiating a new @article variable.
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
     flash[:notice] = "Article was successfully updated"
     redirect_to article_path(@article)
    else
    render 'edit'  #render the edit template again if the update hasn’t worked
    end
  end

  def show
  @article = Article.find(params[:id])  #params is a hash of the entry’s fields.  ID, title, #desc, etc.
  end


  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  
  
end