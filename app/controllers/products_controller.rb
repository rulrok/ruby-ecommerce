class ProductsController < CustomerController
  before_action :redirect_admin

  # GET /products
  # GET /products.json
  def index
    redirect_to :root
    # @products = Product.where(product_available: true)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    render 'not_available' unless @product.product_available?
  end

  def not_available
  end
end
