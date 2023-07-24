class RenameTransactionFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :due_at, :emitted_at
    rename_column :transactions, :amount_to_pay, :amount
  end
end
