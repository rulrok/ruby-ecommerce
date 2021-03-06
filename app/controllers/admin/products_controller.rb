module Admin
  class ProductsController < Admin::AdminController
    before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

    # GET /admin/products
    # GET /admin/products.json
    def index
      page = params[:page].to_i
      @admin_products = Product.page(page).per(10)
    end

    # GET /admin/products/1
    # GET /admin/products/1.json
    def show
    end

    # GET /admin/products/new
    def new
      @product = Product.new
    end

    # GET /admin/products/1/edit
    def edit
    end

    # POST /admin/products
    def create
      @product = Product.new(admin_product_params)
      respond_to do |format|
        if @product.save
          format.html { redirect_to [:admin, @product], notice: 'Product created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /admin/products/1
    def update
      respond_to do |format|
        if @product.update(admin_product_params)
          format.html do
            redirect_to admin_product_path(@product),
                        notice: 'Product was successfully updated.'
          end
        else
          format.html { render :edit }

        end
      end
    end

    # DELETE /admin/products/1
    # DELETE /admin/products/1.json
    def destroy
      @product.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_products_url,
                      notice: 'Product was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def admin_product_params
      params.require(:product).permit(:product_name,
                                      :short_description,
                                      :product_long_description,
                                      :category_id,
                                      :quantity_per_unit,
                                      :unit_price, :discount,
                                      :discount_available,
                                      :unit_weight, :unit_in_stock,
                                      :product_available, :picture_url,
                                      :photo, :image_delete)
    end
  end
end
