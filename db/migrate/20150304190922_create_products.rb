class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :product_description
      t.integer :category_id
      t.integer :quantity_per_unit
      t.decimal :unit_price
      t.decimal :discount
      t.boolean :discount_available, default: false
      t.integer :unit_weight
      t.integer :unit_in_stock
      t.boolean :product_available
      t.string :picture_url

      t.timestamps null: false
    end
  end
end
