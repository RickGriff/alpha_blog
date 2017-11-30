class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout "application"
  
  helper_method :current_user, :logged_in? # make these methods available to our views (as key-value pairs in the params?)
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #return current user if @current_user already exists.
    #if there's no current user, return the user with ID == session user ID, if there is one.
  end
    
  def logged_in?
    !!current_user  #return true if there'a current_user, false otherwise.  (!! converts operand to it's boolean -  returns truthiness.)
  end
  
  def require_user #check if there's a logged in user.  If none, redirect to root path with a flash error message.
    if !logged_in?
    flash[:danger] = "You must be logged in to perform this action!"
    redirect_to root_path
    end
  end
end
