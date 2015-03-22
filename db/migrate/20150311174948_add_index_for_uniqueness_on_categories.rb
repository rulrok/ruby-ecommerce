class AddIndexForUniquenessOnCategories < ActiveRecord::Migration
  def change
    add_index :categories, [:name, :ancestry], unique: true
    remove_column :categories, :parent_id
  end
end
