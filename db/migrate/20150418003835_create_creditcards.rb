class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.string :number
      t.string :name_on_card
      t.integer :month, limit: 2
      t.integer :year, limit: 4
      t.integer :cvv, limit: 4

      t.timestamps null: false
    end
  end
end
