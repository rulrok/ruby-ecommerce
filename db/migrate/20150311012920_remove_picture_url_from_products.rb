class RemovePictureUrlFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :picture_url, :string
  end
end
