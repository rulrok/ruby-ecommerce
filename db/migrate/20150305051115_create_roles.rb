class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, default: 'customer', required: true, limit: 45, unique: true, null: false

      t.timestamps null: false
    end
  end
end
