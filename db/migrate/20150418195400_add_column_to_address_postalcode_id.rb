class AddColumnToAddressPostalcodeId < ActiveRecord::Migration
  def change
    add_column :addresses, :postalcode_id, :integer
  end
end
