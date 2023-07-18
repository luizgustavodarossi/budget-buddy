class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.integer :kind
      t.references :categories, null: false, foreign_key: true
      t.references :accounts, null: false, foreign_key: true
      t.date :due_at
      t.decimal :amount_to_pay
      t.date :paid_at
      t.decimal :amount_paid
      t.text :observation

      t.timestamps
    end
  end
end
