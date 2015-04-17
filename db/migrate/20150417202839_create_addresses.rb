class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_line_1
      t.string :street_line_2

      t.timestamps null: false
    end
  end
end
