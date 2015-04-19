class CategoriesController < ApplicationController
  add_breadcrumb 'Categories', :categories_path

  # GET /categories
  def index
    # add_breadcrumb "Categories", link_to: :categories
    @categories = Category.all
  end

  def show
    @category = category
    mount_breadcrumbs

    category_tree = @category.subtree
    @products = Product.where(category: category_tree, product_available: true)
                .page(params[:page].to_i)
                .per(7)
  end

  def mount_breadcrumbs
    path = @category.path.from_depth(1)
    path.each do |category|
      add_breadcrumb category.name, category
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  private

  def category
    Category.find(params[:id])
  end
end
