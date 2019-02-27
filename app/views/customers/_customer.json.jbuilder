json.extract! customer, :id, :person_id, :payment_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
