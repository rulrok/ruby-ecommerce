class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def index
    redirect_admin #A administrator is not allowed to browse through the store.
  end

  protected

  # @return [User]
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    current_user != nil
  end

  def expel (message = "You must be logged in")
    #I've tried to use redirect with code 401 to be concise with HTTP codes, but it will not work.
    #See http://stackoverflow.com/questions/6113014/what-http-code-to-use-in-not-authenticated-and-not-authorized-cases for details
    redirect_to :log_in, alert: message #, status: :unauthorized
  end

  def ensure_session_time
    #Idea got from here http://stackoverflow.com/questions/17480487/rails-4-session-expiry

    if session[:expires_at] < Time.current
      expel "You session has finished"
    end
  end

  def authenticate_user
    expel unless logged_in?
  end

  def authenticate_admin
    if current_user.nil? || !current_user.admin?
      #Redirects the user to a '404' page, giving the sensation that '/admin' does not exist
      redirect_to '/404' #, :notice => "You do not have authorization to do so!"
    end
  end

  def redirect_admin
    redirect_to '/admin' if current_user.admin? unless current_user.nil?
    return
  end
end
