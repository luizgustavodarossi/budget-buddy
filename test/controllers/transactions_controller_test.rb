require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference("Transaction.count") do
      post transactions_url, params: { transaction: { accounts_id: @transaction.accounts_id, amount_paid: @transaction.amount_paid, amount_to_pay: @transaction.amount_to_pay, categories_id: @transaction.categories_id, description: @transaction.description, due_at: @transaction.due_at, kind: @transaction.kind, observation: @transaction.observation, paid_at: @transaction.paid_at } }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { accounts_id: @transaction.accounts_id, amount_paid: @transaction.amount_paid, amount_to_pay: @transaction.amount_to_pay, categories_id: @transaction.categories_id, description: @transaction.description, due_at: @transaction.due_at, kind: @transaction.kind, observation: @transaction.observation, paid_at: @transaction.paid_at } }
    assert_redirected_to transaction_url(@transaction)
  end

  test "should destroy transaction" do
    assert_difference("Transaction.count", -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
