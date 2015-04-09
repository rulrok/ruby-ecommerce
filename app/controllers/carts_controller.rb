class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items

    add_breadcrumb 'Shopping cart'
  end
end
