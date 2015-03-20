class CategoriesController < ApplicationController



  # GET /categories
  # GET /categories.json
  def index
    add_breadcrumb "Categories", link_to: :categories
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    add_breadcrumb "Categories", categories_path
    @category = Category.find(params[:id])
    path = @category.path.from_depth(1)
    path.each do |category|
      add_breadcrumb category.name,  category
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

end
