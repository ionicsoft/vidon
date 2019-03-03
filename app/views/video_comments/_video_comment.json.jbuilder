json.extract! video_comment, :id, :video_id, :customer_id, :comment, :created_at, :updated_at
json.url video_comment_url(video_comment, format: :json)
