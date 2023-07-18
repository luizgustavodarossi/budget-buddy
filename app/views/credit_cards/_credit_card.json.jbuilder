json.extract! credit_card, :id, :name, :kind, :balance, :closes_day, :expire_day, :created_at, :updated_at
json.url credit_card_url(credit_card, format: :json)
