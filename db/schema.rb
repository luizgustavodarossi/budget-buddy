# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_18_234739) do
  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.decimal "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.decimal "balance"
    t.integer "closes_day"
    t.integer "expire_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "transaction_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "description"
    t.integer "kind"
    t.integer "categories_id", null: false
    t.integer "accounts_id", null: false
    t.date "due_at"
    t.decimal "amount_to_pay"
    t.date "paid_at"
    t.decimal "amount_paid"
    t.text "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_groups_id"
    t.integer "user_id"
    t.index ["accounts_id"], name: "index_transactions_on_accounts_id"
    t.index ["categories_id"], name: "index_transactions_on_categories_id"
    t.index ["transaction_groups_id"], name: "index_transactions_on_transaction_groups_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "transactions", "accounts", column: "accounts_id"
  add_foreign_key "transactions", "categories", column: "categories_id"
  add_foreign_key "transactions", "transaction_groups", column: "transaction_groups_id"
  add_foreign_key "transactions", "users"
end
