class Payment < ActiveRecord::Base
  belongs_to :order
  belongs_to :creditcard

  def associate_creditcard!(creditcard)
    update_attribute :creditcard, creditcard
    save
  end
end
