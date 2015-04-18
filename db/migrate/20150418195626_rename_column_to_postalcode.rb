class RenameColumnToPostalcode < ActiveRecord::Migration
  def change
    rename_column :postalcodes, :postalcode, :postalcode_name
  end
end
