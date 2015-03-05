class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def index
    redirect_admin #A administrator is not supposed to browser through the store.
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

  def authenticate_admin
    if current_user.nil? || !current_user.admin?
      redirect_to root_url, :notice => "You do not have authorization to do so!"
    end
  end

  def redirect_admin
    redirect_to '/admin' if current_user.admin? unless current_user.nil?
    return
  end
end
