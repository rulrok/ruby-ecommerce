class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  has_one :payment

  has_one :shipping_address, class_name: 'Address', foreign_key: :shipping_address_id
  has_one :billing_address, class_name: 'Address', foreign_key: :billing_address_id

  has_many :order_items

  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect do |oi|
      oi.valid? ? (oi.quantity * oi.unit_price) : 0
    end.sum
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
