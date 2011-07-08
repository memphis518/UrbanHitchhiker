class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def login_required
    if session[:user_id]
      return true
    end
    session[:return_to]=request.fullpath
    redirect_to :controller => "users", :action => "login"
    return false 
  end
 
  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to(return_to)
    else
      redirect_to "/users/" + session[:user_id].to_s + "/edit"
    end
  end
  
end
