module Admin
  class OrdersController < Admin::AdminController
    before_action :set_admin_order, only: [:show, :edit, :update, :destroy]

    # GET /admin/user/:id/orders
    def index
      @user = User.find(params[:user_id])
      page = params[:page].to_i
      @orders = Order.page(page).per(10).where(user: @user)
    end

    # GET /admin/orders/1
    # GET /admin/orders/1.json
    def show
    end

    # GET /admin/orders/new
    def new
      @order = Order.new
    end

    # GET /admin/orders/1/edit
    def edit
    end

    # POST /admin/orders
    def create
      @order = Order.new(admin_order_params)
      respond_to do |format|
        if @order.save
          format.html { redirect_to [:admin, @order], notice: 'Order created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /admin/orders/1
    def update
      respond_to do |format|
        if @order.update(admin_order_params)
          format.html do
            redirect_to admin_order_path(@order),
                        notice: 'Order was successfully updated.'
          end
        else
          format.html { render :edit }

        end
      end
    end

    # DELETE /admin/orders/1
    # DELETE /admin/orders/1.json
    def destroy
      @order.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_orders_url,
                      notice: 'Order was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def admin_order_params
      params.require(:order)
          .permit(:email, :password, :password_confirmation)
    end
  end
end
