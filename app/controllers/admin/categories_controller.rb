module Admin
  class CategoriesController < Admin::AdminController
    before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

    # GET /admin/categories
    # GET /admin/categories.json
    def index
      @all_categories = Category.all
    end

    # GET /admin/categories/except/:id
    def except
      respond_to do |format|
        format.json do
          render nothing: true, status: :bad_request if params[:id].nil?
          @element = Category.find(params[:id])
          @sub_tree = @element.ancestors
          @children = Category.find_children(params[:id])
        end
        format.html { render nothing: true, status: :OK }
      end
    end

    # GET /admin/categories/1
    # GET /admin/categories/1.json
    def show
    end

    # GET /admin/categories/new
    def new
      @category = Category.new
    end

    # GET /admin/categories/1/edit
    def edit
    end

    # GET /admin/categories/children/:parent_id.json
    def children
      respond_to do |format|
        format.json do
          render nothing: true, status: :bad_request if params[:parent_id].nil?
          @children = Category.find_children(params[:parent_id])
        end
        format.html { render nothing: true, status: :OK }
      end
    end

    # POST /admin/categories
    # POST /admin/categories.json
    def create
      @category = Category.new(admin_category_params)

      respond_to do |format|
        if @category.save
          format.html do
            redirect_to admin_category_path(@category), notice: 'Category was successfully created.'
          end
          format.json do
            render :show, status: :created, location: [:admin, @category]
          end
        else
          format.html { render :new }
          format.json do
            render json: @category.errors, status: :unprocessable_entity
          end
        end
      end
    end

    # PATCH/PUT /admin/categories/1
    # PATCH/PUT /admin/categories/1.json
    def update
      respond_to do |format|
        if @category.update(admin_category_params)
          format.html do
            redirect_to admin_category_path(@category),
                        notice: 'Category was successfully updated.'
          end
          format.json do
            render :show, status: :ok, location: [:admin, @category]
          end
        else
          format.html { render :edit }
          format.json do
            render json: @category.errors, status: :unprocessable_entity
          end
        end
      end
    end

    # DELETE /admin/categories/1
    # DELETE /admin/categories/1.json
    def destroy
      @category.destroy

      respond_to do |format|
        if @category.destroyed?
          format.html do
            redirect_to admin_categories_url,
                        notice: 'Category was successfully destroyed.'
          end
          format.json { head :no_content }
        else
          message = 'Category could not be destroyed. Verify if one of its subcategories already exist in the upper level of the tree. Also, verify if that category has no products registered with it.'
          format.html do
            redirect_to admin_categories_url,
                        notice: message,
                        status: :unprocessable_entity
          end
          format.json { render json: message, status: :unprocessable_entity }
        end
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def admin_category_params
      params.require(:category).permit(:name, :parent_id)
    end
  end
end
