class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout "application"
  
  helper_method :current_user, :logged_in? # makes these methods available to our views (as key-value pairs in the params?)
  
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #return current user if @current_user already exists.
    #if there's no current user, return the user with ID == session user ID, if there is one.
  end
    
  def logged_in?
    !!current_user  #return true if there'a current_user, false otherwise.  (!! converts anything to boolean. returns truthiness.)
  end
  
  def require_user #require a logged in user.  If none, redirects to root path with error message.
    if !logged_in?
    flash[:danger] = "You must be logged in to perform this action!"
    redirect_to root_path
    end
  end
end
