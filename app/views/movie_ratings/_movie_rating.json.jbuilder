json.extract! movie_rating, :id, :movie_id, :rating, :created_at, :updated_at
json.url movie_rating_url(movie_rating, format: :json)
