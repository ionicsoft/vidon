json.extract! profile_comment, :id, :creation, :customer_id, :commentor_id, :comment, :created_at, :updated_at
json.url profile_comment_url(profile_comment, format: :json)
