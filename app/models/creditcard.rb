class Creditcard < ActiveRecord::Base

  belongs_to :user
  has_many :payments

end
