json.extract! person, :id, :username, :email, :password, :first_name, :last_name, :user_id, :user_type, :created_at, :updated_at
json.url person_url(person, format: :json)
