class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "addresses", "postalcodes", name: "addresses_postalcode_id_fk"
    add_foreign_key "addresses", "provinces", name: "addresses_province_id_fk"
    add_foreign_key "addresses", "users", name: "addresses_user_id_fk"
    add_foreign_key "orders", "addresses", column: "billing_address_id", name: "orders_billing_address_id_fk"
    add_foreign_key "orders", "addresses", column: "shipping_address_id", name: "orders_shipping_address_id_fk"
    add_foreign_key "users", "roles", name: "users_role_id_fk"
  end
end
