class CartsController < ApplicationController
  def show
    add_breadcrumb 'Shopping cart'

    @order_items = current_order.order_items
    @province = current_province
    @tax_over_products = @province.calculate_taxes current_order.subtotal
  end
end
