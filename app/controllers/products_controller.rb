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

    # search terms. Replaces commas by spaces. Removes initial and final spaces before.
    search_expression = params[:search].lstrip.rstrip.gsub(',', ' ')
    @search_terms = search_expression.split(' ')

    @products = Product.search do

      # ============= Searching and boosting

      fulltext search_expression do
        phrase_fields product_name: 2.0 # if the search terms are close related in the product name
        boost_fields product_name: 1.5 # if the search terms are present, but not necessarily very related
        # boost (5.0) { with(:discount_available, true) } if params[:with_discount].present?
        # phrase_slop 10
      end

      # ============= Filtering
      with :product_available, true
      with :discount_available, true if params[:offers_only].present?
      with(:price).greater_than_or_equal_to(params[:minimum_price].to_i) if params[:minimum_price].present?
      with(:price).less_than_or_equal_to(params[:maximum_price].to_i) if params[:maximum_price].present?
      with(:created_at).greater_than_or_equal_to(Time.now - 1.day) if params[:new_products].present?

      # ============= Filtering category
      # It is important to also consider all the descendant categories from the current one. This is why we must fill
      # the second parameter of 'with' with the children ids as well the own category id (!)
      category = Category.find(params[:category]) unless params[:category].nil? || params[:category].empty?
      with(:category_id, category.child_ids << category.id) if category

      # ============= Sorting

      if params[:with_discount].present?
        order_by(:discount, :desc)
      else

      end
      order_by(:updated_at, :asc)

      # ============= Paginating
      paginate page: params[:page], per_page: 5
    end

    respond_to do |format|
      format.html { render action: 'search_results' }
      format.json { render json: @products }
      format.xml { render xml: @products }
    end
  end
end
