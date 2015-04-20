class AddCollumToCreditcardUserid < ActiveRecord::Migration
  def change
    add_column :creditcards, :user_id, :integer
  end
end
