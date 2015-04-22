class OrderStatus < ActiveRecord::Base
  has_many :orders

  self::OPENED = 1
  self::IN_PROGRESS = 10
  self::PAID = 20
  self::SHIPPED = 30
  self::CANCELLED = 40

  def self.construct_status(type)
    cases = { opened: 1, open: 1,
              in_progress: 10,
              paid: 20,
              shipped: 30, ship: 30,
              cancelled: 40, cancel: 40 }
    status_id = cases.fetch(type) || 10 # 10 = default case

    find(status_id)
  end
end
