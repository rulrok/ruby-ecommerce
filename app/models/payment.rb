class Payment < ActiveRecord::Base
  belongs_to :order
  belongs_to :creditcard

  def make_payment(_user)
    order
  end
end
