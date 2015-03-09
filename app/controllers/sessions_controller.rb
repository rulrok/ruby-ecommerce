class SessionsController < ApplicationController

  layout "login"

  #Login page
  def new
    @action_name = "Login"
    @ecommerce_name = Setting.obtain :title
    redirect_to root_url unless current_user.nil?
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      if params[:remember].nil?
        session[:expires_at] = Time.now + 24.hours
      else
        session[:expires_at] = Time.now + 9999.days
      end
      if user.admin?
        redirect_admin
      else
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session.clear()
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
