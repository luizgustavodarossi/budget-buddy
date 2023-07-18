class AddTransactionGroupsRefTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :transaction_groups, foreign_key: true
  end
end
