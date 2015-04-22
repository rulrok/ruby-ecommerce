class Creditcard < ActiveRecord::Base
  belongs_to :user
  has_many :payments

  def authorize_payment(_order)
    true
  end
end
