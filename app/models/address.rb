class Address < ActiveRecord::Base
  belongs_to :postalcode
  belongs_to :user
  belongs_to :province

  # has_one :shipping_address, class_name: 'Address', foreign_key: :shipping_address_id
  # has_one :billing_address, class_name: 'Address', foreign_key: :billing_address_id

  has_many :shipping_addresses, class_name: 'Order', foreign_key: 'shipping_address_id'
  has_many :billing_addresses, class_name: 'Order', foreign_key: 'billing_address_id'
end
