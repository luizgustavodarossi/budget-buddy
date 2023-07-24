class AddPolymorphicRefTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transactions, :account, null: false, foreign_key: true

    add_reference :transactions, :accountable, polymorphic: true, null: false
  end
end
