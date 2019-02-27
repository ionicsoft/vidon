json.extract! payment, :id, :card_name, :card_num, :cvc, :expiration, :created_at, :updated_at
json.url payment_url(payment, format: :json)
