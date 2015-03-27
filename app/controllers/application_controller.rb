class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :categories_search_bar

  helper_method :current_user, :logged_in?

  add_breadcrumb 'Home', :root_path

  def index
    # A administrator is not allowed to browse through the store.
    redirect_admin

    @popular_products = Product.where(product_available: true).limit(9)

    @offers = Product.where(discount_available: true).order(:updated_at).limit(5)
  end

  def about
    add_breadcrumb 'About', about_path

    @about_content = Setting.obtain('about-content').html_safe # Maybe .html_safe could go directly in the method obtain. Not sure yet
  end

  def contact
    add_breadcrumb 'Contact', contact_path

    @contact_content = Setting.obtain('contact-content').html_safe
  end

  def sales
    add_breadcrumb 'Sales', sales_path
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

  def expel(message = 'You must be logged in')
    # I've tried to use redirect with code 401 to be concise with HTTP codes, but it will not work.
    # See http://stackoverflow.com/questions/6113014/what-http-code-to-use-in-not-authenticated-and-not-authorized-cases for details
    redirect_to :log_in, alert: message # , status: :unauthorized
  end

  def ensure_session_time
    # Idea got from here http://stackoverflow.com/questions/17480487/rails-4-session-expiry

    if session[:expires_at] < Time.current
      expel 'You session has finished'
    end
  end

  def authenticate_user
    expel unless logged_in?
  end

  def authenticate_admin
    if current_user.nil? || !current_user.admin?
      # Redirects the user to a '404' page, giving the sensation that '/admin' does not exist
      redirect_to '/404' # , :notice => "You do not have authorization to do so!"
    end
  end

  def redirect_admin
    redirect_to '/admin' if current_user.admin? unless current_user.nil?
      end

  private

  def categories_search_bar
    @categories_search = Category.from_depth(1)
  end
end
