module SessionsHelper
  
  #Log in the given user
  def log_in(user)
    #Sessions are automatically encrypted
    session[:user_id] = user.id
  end
  
  #Returns the current logged-in user, and if there isn't one, it returns nil
  def current_user
    if session[:user_id]
      #same as @current user = @current user if it's already defined in the 
      #current method, else it equals User.find_by...
      return @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  #Returns true if the user is logged in, false otherwise
  def logged_in?
    return !current_user.nil?
  end
  
  #Logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user?(user)
    return user == current_user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:fowarding_url)
  end 
  
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
