class AddUserRefAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :users, foreign_key: true
  end
end
