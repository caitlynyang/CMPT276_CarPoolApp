module SessionsHelper
  #login to User
  def log_in(user)
    session[:user_id] = user.id
  end

  #return to current User
  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end
  #if user already login return true else return false
  def logged_in?
    !current_user.nil?
  end

  #log out current User
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

# Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
