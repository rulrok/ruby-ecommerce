class Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  belongs_to :order_status
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'

  has_one :payment, autosave: true

  has_many :order_items, dependent: :delete_all

  # before_create :set_order_status
  before_save :update_subtotal, :update_taxes

  def associate_addresses!(shipping_address, billing_address)
    self.shipping_address = shipping_address
    self.billing_address = billing_address
    save
  end

  def to_s
    "##{id}"
  end

  def subtotal
    order_items.collect do |oi|
      oi.valid? ? (oi.quantity * oi.unit_price) : 0
    end.sum
  end

  def set_order_status
    self.order_status = OrderStatus.construct_status :opened if order_status.nil?
  end

  def opened?
    order_status.id.equal? OrderStatus::OPENED
  end

  def in_progress?
    order_status.id.equal? OrderStatus::IN_PROGRESS
  end

  def in_progress!
    self.order_status = OrderStatus::IN_PROGRESS
    save
  end

  def paid?
    order_status.id.equal? OrderStatus::PAID
  end

  def paid!
    self.order_status = OrderStatus::PAID
    save
  end

  def shipped?
    order_status.id.equal? OrderStatus::SHIPPED
  end

  def shipped!
    self.order_status = OrderStatus::SHIPPED
    save
  end

  def cancelled?
    order_status.id.equal? OrderStatus::CANCELLED
  end

  def cancel!
    self.order_status = OrderStatus::CANCELLED
    save
  end

  private

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_taxes
    # self[:tax] =
  end
end
