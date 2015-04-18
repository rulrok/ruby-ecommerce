class Province < ActiveRecord::Base
  has_many :postalcodes
  has_many :addresses, through: :postalcodes

  def full_name
    "#{name} (#{code})"
  end
end
