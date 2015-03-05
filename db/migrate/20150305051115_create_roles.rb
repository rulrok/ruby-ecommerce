class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, default: 'customer'

      t.timestamps null: false
    end
  end
end
