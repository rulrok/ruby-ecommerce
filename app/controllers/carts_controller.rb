class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items

    add_breadcrumb 'Shopping cart'
  end

  # GET /cart/checkout
  def checkout
    add_breadcrumb 'Cart', cart_path
    add_breadcrumb 'Cart checkout'

    @ship_address = Address.new
  end

  # POST /cart/checkout
  def checkout_address
    render json: params
  end

  def checkout_payment

  end
end
