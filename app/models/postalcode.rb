class Postalcode < ActiveRecord::Base
  belongs_to :province
  has_many :addresses

  validates :postalcode, :city, presence: true
end
