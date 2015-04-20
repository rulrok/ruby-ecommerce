class OrderStatus < ActiveRecord::Base
  has_many :orders

  def self.construct_status(type)
    case type
      when :opened
        find(1)
      when :in_progress
        find(10)
      when :paid
        find(20)
      when :shipped
        find(30)
      when :cancelled
        find(40)
      else
        find(10)
    end
  end
end
