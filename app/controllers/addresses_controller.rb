class AddressesController < ApplicationController
  def show
    @address = Address.find(params[:id])
  end

  # POST /address
  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to admin_category_path(@address), notice: 'Address created.'
    else
      redirect_to :back, notice: 'Could not create the address'
    end
  end

  private

  def address_params
    params.require(:address)
      .permit(:street_line_1, :street_line_2, :city, :province, :postal_code)
  end
end
