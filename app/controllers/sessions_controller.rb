class SessionsController < ApplicationController
  layout 'login'

  before_action :ecommerce_name, only: [:new, :create]

  # Login page
  def new
    redirect_to root_url unless current_user.nil?
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user

      process_user_order(user)

      start_session user

    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    current_order.user = current_user
    current_order.save

    session.clear
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  private

  def process_user_order(user)
    last_order = user.orders.last
    if last_order.present? && last_order.in_progress?
      # The user has one unfinished order from a previous session
      session[:order_id] = last_order.id
    else
      # The user is only relying on the new created order
      order = current_order
      if order.user.nil?
        order.user = user
        order.save
      end
    end
  end

  def start_session(user)
    prepare_session(user)
    if user.admin?
      redirect_admin
    else
      redirect_to root_url, notice: 'Logged in!'
    end
  end

  def prepare_session(user)
    session[:user_id] = user.id
    session[:expires_at] = Time.now + (params[:remember].nil? ? 24.hours : 9999.days)
  end

  def ecommerce_name
    @ecommerce_name = Setting.obtain :title
  end
end
