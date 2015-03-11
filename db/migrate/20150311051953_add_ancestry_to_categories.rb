class AddAncestryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ancestry, :string
    add_column :categories, 'ancestry_depth', :string
  end
end
