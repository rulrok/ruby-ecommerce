class AddUniquenessColumnsTogether < ActiveRecord::Migration
  def change
    add_index :creditcards, [:number, :name_on_card, :month, :year, :user_id], unique: true, name: :unique_constraint
  end
end
