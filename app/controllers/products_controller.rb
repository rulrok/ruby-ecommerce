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

    @category = @product.category
    path = @category.path.from_depth(1)
    path.each do |category|
      add_breadcrumb category.name, category
    end

    @order_item = current_order.order_items.new

    add_breadcrumb @product.product_name
    render 'not_available' unless @product.product_available?
  end

  def not_available
  end

  # GET /products/search
  # GET /products/search.json
  # GET /products/search.xml
  def search
    add_breadcrumb 'Search results'

    # Replaces commas by spaces. Removes initial and final spaces before.
    search_expression = params[:search].lstrip.rstrip.gsub(',', ' ')
    @search_terms = search_expression.split(' ')

    category = Category.find(params[:category]) \
        unless params[:category].nil? || params[:category].empty?

    @products = Product.search_product search_expression,
                                       category: category,
                                       with_discount: params[:with_discount],
                                       offers_only: params[:offers_only],
                                       minimum_price: params[:minimum_price],
                                       maximum_price: params[:maximum_price],
                                       new_products: params[:new_products],
                                       page: params[:page]
    respond_to do |format|
      format.html { render action: 'search_results' }
      format.json { render json: @products }
    end
  end
end
