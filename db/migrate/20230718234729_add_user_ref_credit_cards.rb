class AddUserRefCreditCards < ActiveRecord::Migration[7.0]
  def change
    add_reference :credit_cards, :users, foreign_key: true
  end
end
