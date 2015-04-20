class Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  belongs_to :order_status
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'

  has_one :payment, autosave: true

  has_many :order_items, dependent: :delete_all

  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect do |oi|
      oi.valid? ? (oi.quantity * oi.unit_price) : 0
    end.sum
  end

  def set_order_status
    self.order_status = OrderStatus.construct_status :opened if order_status.nil?
  end

  def opened?
    order_status.equal? OrderStatus.construct_status :opened
  end

  def in_progress?
    order_status.equal? OrderStatus.construct_status :in_progress
  end

  def in_progress!
    self.order_status = OrderStatus.construct_status :in_progress
    save
  end

  def paid?
    order_status.equal? OrderStatus.construct_status :paid
  end

  def paid!
    self.order_status = OrderStatus.construct_status :paid
    save
  end

  def shipped?
    order_status.equal? OrderStatus.construct_status :shipped
  end

  def shipped!
    self.order_status = OrderStatus.construct_status :shipped
    save
  end

  def cancelled?
    order_status.equal? OrderStatus.construct_status :cancelled
  end

  def cancel!
    self.order_status = OrderStatus.construct_status :cancelled
    save
  end

  private

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
