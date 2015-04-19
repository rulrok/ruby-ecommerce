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
    @product = product

    @category = @product.category
    mount_breadcrumbs_show

    @order_item = current_order.order_items.new

    render 'not_available' unless @product.product_available?
  end

  def mount_breadcrumbs_show
    path = @category.path.from_depth(1)
    path.each do |category|
      add_breadcrumb category.name, category
    end
    add_breadcrumb @product.product_name
  end

  # GET /products/search
  # GET /products/search.json
  # GET /products/search.xml
  def search
    add_breadcrumb 'Search results'

    # Replaces commas by spaces. Removes initial and final spaces before.
    search_expression = filter_search_terms
    @search_terms = search_expression.split(' ')

    @products = Product.search_product search_expression, category, params
    respond_to do |format|
      format.html { render action: 'search_results' }
      format.json { render json: @products }
    end
  end

  private

  def filter_search_terms
    params[:search].lstrip.rstrip.gsub(',', ' ')
  end

  def product
    Product.find(params[:id])
  end

  def category
    Category.find(params[:category]) if params[:category].present?
  end
end
