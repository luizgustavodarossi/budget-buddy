json.extract! transaction, :id, :description, :kind, :categories_id, :accounts_id, :due_at, :amount_to_pay, :paid_at, :amount_paid, :observation, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
