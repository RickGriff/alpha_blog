class PagesController < ApplicationController

  def home
    redirect_to articles_path if logged_in?  #if there's a logged in user, redirect user to articles listing.
  end
  
  def about
  end
 
end