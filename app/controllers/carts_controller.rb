class CartsController < ApplicationController

  before_action :verify_logged_user, only: [:checkout, :checkout_address, :checkout_payment, :checkout_complete]

  def show
    @order_items = current_order.order_items

    add_breadcrumb 'Shopping cart'
  end

  # GET /cart/checkout
  def checkout

    add_breadcrumb 'Cart', cart_path
    add_breadcrumb 'Cart checkout'

    @user_addresses = Address.where(user: current_user)
  end


  # POST /cart/checkout
  def checkout_address
    shipping_address = mount_shipping_address
    billing_address = mount_billing_address

    shipping_address.user = current_user
    billing_address.user = current_user

    order = current_order
    order.shipping_address = shipping_address
    order.billing_address = billing_address

    if shipping_address.save && order.save
      redirect_to :checkout_payment
    else
      render 'layouts/application', notice: 'We could not save address to your order.'
    end
  end

  # GET /cart/checkout/payment
  def checkout_payment
    add_breadcrumb 'Cart', cart_path
    add_breadcrumb 'Cart checkout'
  end

  # POST /cart/checkout/payment
  def create_payment
    order = current_order
    user = current_user

    begin
      creditcard = Creditcard.find_or_create_by(creditcard_params)
      user.creditcards << creditcard

      order.payment = Payment.new
      order.payment.creditcard = creditcard
      order.paid!

      user.orders << order
      user.save

      clear_current_order
    end unless order.paid?

    redirect_to :checkout_complete, notice: 'asdf'
  end


  def checkout_complete

  end

  private

  def verify_logged_user
    redirect_to :log_in, notice: 'You must be be logged in to checkout' if current_user.nil?
  end

  def mount_shipping_address
    shipping_address = if params[:shipping_address][:address_id].present?
                         Address.find(params[:shipping_address][:address_id])
                       else
                         Address.new(shipping_address_params)
                       end
    shipping_address.postalcode = Postalcode.new(shipping_postalcode_params)
    shipping_address
  end

  def mount_billing_address
    billing_address = if params[:billing_address][:address_id].present?
                        Address.find(params[:billing_address][:address_id])
                      else
                        Address.new(billing_address_params)
                      end
    billing_address.postalcode = Postalcode.new(billing_postalcode_params)
    billing_address
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:street_line_1, :street_line_2, :province_id)
  end

  def shipping_postalcode_params
    params.require(:shipping_address).permit(:postalcode, :city)
  end

  def billing_address_params
    params.require(:billing_address).permit(:street_line_1, :street_line_2, :province_id)
  end

  def billing_postalcode_params
    params.require(:billing_address).permit(:postalcode, :city)
  end

  def creditcard_params
    params.require(:creditcard).permit(:name_on_card, :number, :month, :year, :cvc)
  end

end
