require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "should create transaction" do
    visit transactions_url
    click_on "New transaction"

    fill_in "Accounts", with: @transaction.accounts_id
    fill_in "Amount paid", with: @transaction.amount_paid
    fill_in "Amount to pay", with: @transaction.amount_to_pay
    fill_in "Categories", with: @transaction.categories_id
    fill_in "Description", with: @transaction.description
    fill_in "Due at", with: @transaction.due_at
    fill_in "Kind", with: @transaction.kind
    fill_in "Observation", with: @transaction.observation
    fill_in "Paid at", with: @transaction.paid_at
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "should update Transaction" do
    visit transaction_url(@transaction)
    click_on "Edit this transaction", match: :first

    fill_in "Accounts", with: @transaction.accounts_id
    fill_in "Amount paid", with: @transaction.amount_paid
    fill_in "Amount to pay", with: @transaction.amount_to_pay
    fill_in "Categories", with: @transaction.categories_id
    fill_in "Description", with: @transaction.description
    fill_in "Due at", with: @transaction.due_at
    fill_in "Kind", with: @transaction.kind
    fill_in "Observation", with: @transaction.observation
    fill_in "Paid at", with: @transaction.paid_at
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction" do
    visit transaction_url(@transaction)
    click_on "Destroy this transaction", match: :first

    assert_text "Transaction was successfully destroyed"
  end
end
