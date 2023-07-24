class RemoveTransactionFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :paid_at
    remove_column :transactions, :amount_paid
  end
end
