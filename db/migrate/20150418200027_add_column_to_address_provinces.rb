class AddColumnToAddressProvinces < ActiveRecord::Migration
  def change
    add_column :addresses, :province_id, :integer
  end
end
