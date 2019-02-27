json.extract! movie, :id, :video_id, :producer_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
