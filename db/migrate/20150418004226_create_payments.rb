class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :date
      t.decimal :total
      t.string :details

      t.timestamps null: false
    end
  end
end
