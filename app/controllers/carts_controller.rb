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
    shipping_address = mount_shipping_address
    order = current_order
    order.shipping_address = shipping_address
    if shipping_address.save && order.save
      render json: order
    else
      render 'layouts/admin/error_modal', notice: 'Could not save address'
    end
  end

  def checkout_payment
  end

  private

  def mount_shipping_address
    shipping_address = Address.new(shipping_address_params)
    shipping_address.postalcode = Postalcode.new(shipping_postalcode_params)
    shipping_address
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:street_line_1, :street_line_2, :province_id)
  end

  def shipping_postalcode_params
    params.require(:shipping_address).permit(:postalcode, :city)
  end
end
