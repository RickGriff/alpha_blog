class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)  #
    if user && user.authenticate(params[:session][:password])  #check if there is a user matching the given email and pw
      session[:user_id] = user.id #set the user ID in sessions hash equal to the user ID.  Session is backed by cookie in browser.
      flash[:success] =  "You have successfully logged in"
      redirect_to user_path(user)  #Send them to their User's show page
 
    else #reload login page if not given a user's email and correct pw
      flash.now[:danger] = "There was something wrong with your Login Information"  #flash now pops up immediately, or on rending 'new'. Doesn't get passed to next page.
      render 'new'  
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end
