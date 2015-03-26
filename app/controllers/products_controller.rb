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

  # GET /products/search
  # GET /products/search.json
  # GET /products/search.xml
  def search
    add_breadcrumb 'Search results'

    # search terms. Replaces commas by spaces. Removes initial and final spaces before.
    search_expression = params[:search].lstrip.rstrip.gsub(',', ' ')
    @search_terms = search_expression.split(' ')

    @products = Product.search do

      fulltext search_expression do
        phrase_fields :product_name => 3.0
        boost_fields :product_name => 2.0
        phrase_slop 10
      end

      # ============= Filtering
      with :product_available, true
      with :discount_available, true if params[:with_discount].present?
      with(:created_at).greater_than_or_equal_to(Time.now - 1.day) if params[:new_products].present?

      # ============= Filter category
      category = Category.find(params[:category]) unless params[:category].nil? or params[:category].blank?
      with(:category_id, category.child_ids << category.id) unless category.nil?

      # ============= Sorting
      order_by(:updated_at,:desc)
    end.results

    respond_to do |format|
      format.html { render :action => "search_results" }
      format.json { render :json => @products }
      format.xml { render :xml => @products }
    end
  end
end
