class SessionsController < ApplicationController
  layout 'login'

  # Login page
  def new
    @action_name = 'Login'
    @ecommerce_name = Setting.obtain :title
    redirect_to root_url unless current_user.nil?
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      start_session user

    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session.clear
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  private

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
end
