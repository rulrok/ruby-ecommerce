class Payment < ActiveRecord::Base
  belongs_to :order
  belongs_to :creditcard
  #
  # validates :total, :presence => true
  # validates :details, :presence => true, if: Proc.new { |a| a.creditcard_id.nil? }

  def associate_creditcard!(creditcard)
    update_attribute :creditcard, creditcard
    save
  end
end
