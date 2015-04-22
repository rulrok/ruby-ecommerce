class ChangeColumnTotalFromPayment < ActiveRecord::Migration
  def change
    change_column :payments, :total, :decimal, :precision => 12, :scale => 3
  end
end
