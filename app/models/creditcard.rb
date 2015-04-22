class Creditcard < ActiveRecord::Base
  belongs_to :user
  has_many :payments

  validates :number, :name_on_card, :month, :year, :cvc, :user_id, presence: true
  validates :number, length: 16

  def authorize_payment(_order)
    true
  end
end
