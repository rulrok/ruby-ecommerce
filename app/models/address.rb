class Address < ActiveRecord::Base

  belongs_to :postalcode
  belongs_to :user
end
