class AddColumnToPaymentsOrderid < ActiveRecord::Migration
  def change
    add_column :payments, :order_id, :integer
    add_column :payments, :creditcard_id, :integer

    add_foreign_key :payments, :orders
    add_foreign_key :payments, :creditcards
  end
end
