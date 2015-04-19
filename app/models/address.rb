class Address < ActiveRecord::Base
  belongs_to :postalcode
  belongs_to :user, autosave: true
  belongs_to :province, autosave: true

  # has_one :shipping_address, class_name: 'Address', foreign_key: :shipping_address_id
  # has_one :billing_address, class_name: 'Address', foreign_key: :billing_address_id

  has_many :shipping_addresses, class_name: 'Order', foreign_key: 'shipping_address_id'
  has_many :billing_addresses, class_name: 'Order', foreign_key: 'billing_address_id'

  def to_s
    "#{street_line_1} - #{postalcode.postalcode} - #{postalcode.city} - #{province.name}"
  end
end
