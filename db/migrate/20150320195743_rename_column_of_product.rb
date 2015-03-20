class RenameColumnOfProduct < ActiveRecord::Migration
  def change
    rename_column :products, :product_description, :product_long_description
  end
end
