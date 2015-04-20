class AddKeys2 < ActiveRecord::Migration
  def change
    add_foreign_key "creditcards", "users", name: "creditcards_user_id_fk"
  end
end
