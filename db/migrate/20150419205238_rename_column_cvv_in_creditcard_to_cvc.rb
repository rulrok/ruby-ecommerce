class RenameColumnCvvInCreditcardToCvc < ActiveRecord::Migration
  def change
    rename_column :creditcards, :cvv, :cvc
  end
end
