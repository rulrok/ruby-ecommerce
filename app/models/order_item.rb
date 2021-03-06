class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  validate :product_present
  validate :order_present

  before_save :finalize_prices

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def product_present
    errors.add(:product, 'is not valid or is not active.') if product.nil?
  end

  def order_present
    errors.add(:order, 'is not a valid order.') if order.nil?
  end

  def finalize_prices
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
