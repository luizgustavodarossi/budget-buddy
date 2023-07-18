class CreateCreditCards < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.integer :kind
      t.decimal :balance
      t.integer :closes_day
      t.integer :expire_day

      t.timestamps
    end
  end
end
