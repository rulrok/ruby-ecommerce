class Province < ActiveRecord::Base
  has_many :postalcodes
  has_many :addresses, through: :postalcodes

  validates :pst, :gst, :hst,
            numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1},
            presence: true

  def full_name
    "#{name} (#{code})"
  end
end
