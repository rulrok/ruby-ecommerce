class CategoriesController < ApplicationController

  add_breadcrumb "Categories", :categories_path

  # GET /categories
  def index
    # add_breadcrumb "Categories", link_to: :categories
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    path = @category.path.from_depth(1)
    path.each do |category|
      add_breadcrumb category.name,  category
    end

    #TODO Verify if the subtree is working properly
    category_tree = @category.subtree
    @products = Product.where(category: category_tree, product_available: true)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

end
