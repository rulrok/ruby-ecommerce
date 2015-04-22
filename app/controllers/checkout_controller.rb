class CheckoutController < ApplicationController
  before_action :verify_logged_user,
                only: [:checkout, :checkout_address, :checkout_payment, :checkout_complete]

  # GET /cart/checkout
  def checkout
    add_breadcrumb 'Cart', cart_path
    add_breadcrumb 'Cart checkout'

    @province = current_province
    @user_addresses = Address.where(user: current_user)
  end

  # POST /cart/checkout
  def checkout_address
    shipping_address = mount_shipping_address
    billing_address = mount_billing_address

    order = current_order
    order.associate_addresses!(shipping_address, billing_address)

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
    order = update_order_prices

    make_payment(order) unless order.paid?

    if order.paid?
      session[:last_order_completed] = order.id
      redirect_to :checkout_complete, notice: 'Order completed'
    else
      redirect_to :checkout_payment, error: 'Payment not authorized!'
    end
  end

  def update_order_prices
    order = current_order
    order.update_taxes current_province.calculate_taxes(order.subtotal)
    order.update_shipping_cost 0
    order
  end

  # GET /cart/checkout/complete
  def checkout_complete
  end

  private

  def make_payment(order)
    creditcard = Creditcard.find_or_create_by(creditcard_params)

    begin
      order.payment = Payment.create
      order.payment.associate_creditcard! creditcard
      order.update_payment!
      order.paid!
      create_new_order_session
      true
    end if creditcard.authorize_payment order
  end

  def verify_logged_user
    session[:return_url] = 'cart/checkout_path'
    redirect_to :log_in, notice: 'You must be be logged in to checkout' if current_user.nil?
  end

  def mount_shipping_address
    shipping_address = if params[:shipping_address][:address_id].present?
                         Address.find(params[:shipping_address][:address_id])
                       else
                         obtain_shipping_address
                       end
    shipping_address.postalcode = Postalcode.new(shipping_postalcode_params)
    shipping_address.user = current_user
    shipping_address
  end

  def obtain_shipping_address
    add = Address.create(shipping_address_params)
    add.province = current_province
    # add.save
    # add
  end

  def mount_billing_address
    billing_address = if params[:billing_address][:address_id].present?
                        Address.find(params[:billing_address][:address_id])
                      else
                        obtain_billing_address
                      end
    billing_address.postalcode = Postalcode.new(billing_postalcode_params)
    billing_address.user = current_user
    billing_address
  end

  def obtain_billing_address
    add = Address.create(billing_address_params)
    add.province = current_province
    # add.save
    # add
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:street_line_1, :street_line_2)
  end

  def shipping_postalcode_params
    params.require(:shipping_address).permit(:postalcode, :city)
  end

  def billing_address_params
    params.require(:billing_address).permit(:street_line_1, :street_line_2)
  end

  def billing_postalcode_params
    params.require(:billing_address).permit(:postalcode, :city)
  end

  def creditcard_params
    params.require(:creditcard).permit(:name_on_card, :number, :month, :year, :cvc)
  end
end
