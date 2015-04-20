class Role < ActiveRecord::Base
  has_many :users

  def self.user_role
    find_by_name :customer
  end

  def self.admin_role
    find_by_name :administrator
  end
end
