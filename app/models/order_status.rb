class OrderStatus < ActiveRecord::Base
  has_many :orders

  def self.construct_status(type)
    cases = { opened: 1, in_progress: 10, paid: 20, shipped: 30, cancelled: 40 }
    status_id = cases.find_index(type) || 10 # 10 = default case

    find(status_id)
  end
end
