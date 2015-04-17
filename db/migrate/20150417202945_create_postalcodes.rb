class CreatePostalcodes < ActiveRecord::Migration
  def change
    create_table :postalcodes do |t|
      t.string :postalcode
      t.string :city

      t.timestamps null: false
    end
  end
end
