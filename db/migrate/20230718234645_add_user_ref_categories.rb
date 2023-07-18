class AddUserRefCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :users, foreign_key: true
  end
end
