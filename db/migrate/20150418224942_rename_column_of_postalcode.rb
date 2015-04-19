class RenameColumnOfPostalcode < ActiveRecord::Migration
  def change
    rename_column :postalcodes, :postalcode_name, :postalcode
  end
end
