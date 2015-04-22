class CartsController < ApplicationController
  def show
    add_breadcrumb 'Shopping cart'
    @order_items = current_order.order_items
    @tax_over_products = current_province.calculate_taxes current_order.subtotal || 0
  end

  # POST /account/stripe_card_token
  def stripe_card_token
    token = params[:token]
    payment = current_user.payments.last
    payment.details = token
    payment.save
  end
end
