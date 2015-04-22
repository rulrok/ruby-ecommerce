class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :categories_search_bar

  helper_method :current_user, :current_order, :current_order=, :logged_in?

  add_breadcrumb 'Home', :root_path

  def index
    # A administrator is not allowed to browse through the store.
    redirect_admin

    @popular_products = popular_products

    @offers = offers

    @order_item = current_order.order_items.new
  end

  def about
    add_breadcrumb 'About', about_path

    # Maybe .html_safe could go directly in the method obtain. Not sure yet
    @about_content = Setting.obtain('about-content').html_safe
  end

  def contact
    add_breadcrumb 'Contact', contact_path

    @contact_content = Setting.obtain('contact-content').html_safe
  end

  def sales
    add_breadcrumb 'Sales', sales_path
  end

  protected

  def current_order=(order)
    session[:order_id] = order.id
  end

  def current_order
    if session[:order_id].nil?
      create_new_order_session
    else
      begin
        Order.find(session[:order_id])
      rescue
        create_new_order_session
      end
    end
  end

  def current_province
    Province.find(Setting.obtain 'default-province')
  end

  def create_new_order_session
    order = Order.new
    order.order_status = OrderStatus.construct_status :opened
    order.save
    session[:order_id] = order.id
    order
  end

  # @return [User]
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def expel(message = 'You must be logged in')
    # I've tried to use redirect with code 401 to be concise with HTTP codes,
    # but it will not work.
    # See http://bit.ly/1NgoeBi for details
    redirect_to :log_in, alert: message # , status: :unauthorized
  end

  def ensure_session_time
    # Idea got from here
    # http://stackoverflow.com/questions/17480487/rails-4-session-expiry

    expel 'You session has finished' if session[:expires_at] < Time.current
  end

  def authenticate_user
    expel unless logged_in?
  end

  def authenticate_admin
    # Redirects the user to a '404' page,
    # giving the sensation that '/admin' does not exist

    redirect_to '/404' if current_user.nil? || !current_user.admin?
  end

  def redirect_admin
    redirect_to '/admin' if current_user.admin? unless current_user.nil?
  end

  private

  def categories_search_bar
    @categories_search = Category.from_depth(1)
  end

  def offers
    Product.where(discount_available: true)
      .order(:updated_at).limit(5)
  end

  def popular_products
    Product.where(product_available: true).limit(9)
  end
end
