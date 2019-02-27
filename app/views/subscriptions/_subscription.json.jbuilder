json.extract! subscription, :id, :customer_id, :show_id, :current_episode, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
