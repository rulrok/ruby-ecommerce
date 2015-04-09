class UsersController < CustomerController
  layout 'login', only: [:new, :create]

  def new
    @user = User.new
    @action_name = 'Register'
    @ecommerce_name = Setting.obtain :title
  end

  def profile
    authenticate_user
    ensure_session_time
  end

  def create
    @user = User.new(params.require(:user)
                         .permit(:email, :password, :password_confirmation))
    if @user.save
      redirect_to :log_in, notice: 'Signed up! You can log into the site'
    else
      @action_name = 'Register'
      @ecommerce_name = Setting.obtain :title
      render 'new'
    end
  end
end
