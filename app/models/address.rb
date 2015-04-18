class Address < ActiveRecord::Base
  belongs_to :postalcode
  belongs_to :user
  belongs_to :province
  belongs_to :order_shipping, class_name: 'Order', foreign_key: :shipping_address_id
  belongs_to :order_billing, class_name: 'Order', foreign_key: :billing_address_id
end
