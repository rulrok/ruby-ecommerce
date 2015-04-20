module Admin
  class UsersController < Admin::AdminController
    before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

    # GET /admin/users
    # GET /admin/users.json
    def index
      page = params[:page].to_i
      @users = User.page(page).per(10).where(role: Role.user_role)
    end

    # GET /admin/users/1
    # GET /admin/users/1.json
    def show
    end

    # GET /admin/users/new
    def new
      @user = User.new
    end

    # GET /admin/users/1/edit
    def edit
    end

    # POST /admin/users
    def create
      @user = User.new(admin_user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to [:admin, @user], notice: 'User created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /admin/users/1
    def update
      respond_to do |format|
        if @user.update(admin_user_params)
          format.html do
            redirect_to admin_user_path(@user),
                        notice: 'User was successfully updated.'
          end
        else
          format.html { render :edit }

        end
      end
    end

    # DELETE /admin/users/1
    # DELETE /admin/users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_users_url,
                      notice: 'User was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def admin_user_params
      params.require(:user)
          .permit(:email, :password, :password_confirmation)
    end
  end
end
